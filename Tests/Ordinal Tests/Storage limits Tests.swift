#if Tagged
import Cardinal
import Ordinal
import Tagged
import Testing

@Suite(.serialized, .timeLimit(.minutes(1)))
struct `Storage adapters reject unrepresentable values before use` {
    @Test(
        arguments: ["array", "buffer", "mutable-buffer", "span", "mutable-span", "move-initialize", "move-update"],
        [UInt(Int.max) + 1, UInt.max]
    )
    func `counts fail at the exact conversion boundary`(operation: String, raw: UInt) async throws {
        let result = try await #require(
            processExitsWith: .failure,
            observing: [\.standardErrorContent]
        ) { [operation = operation as String, raw = raw as UInt] in
            let count = Tagged<Int, Cardinal>(Cardinal(raw))
            if operation == "array" {
                let _: [Int] = Array(count: count) { _ in
                    preconditionFailure("The element factory must not run")
                }
                return
            }
            let source = UnsafeMutablePointer<Int>.allocate(capacity: 1)
            unsafe source.initialize(to: 10)
            let target = UnsafeMutablePointer<Int>.allocate(capacity: 1)
            switch operation {
            case "buffer":
                let buffer = unsafe UnsafeBufferPointer(start: UnsafePointer(source), count: count)
                precondition(buffer.count >= 0)
            case "mutable-buffer":
                let buffer = unsafe UnsafeMutableBufferPointer(start: source, count: count)
                precondition(buffer.count >= 0)
            case "span":
                let span = unsafe Span(_unsafeStart: UnsafePointer(source), count: count)
                precondition(span.count >= 0)
            case "mutable-span":
                let span = unsafe MutableSpan(_unsafeStart: source, count: count)
                precondition(span.count >= 0)
            case "move-initialize":
                unsafe target.move.initialize(from: source, count: count)
            case "move-update":
                unsafe target.initialize(to: 20)
                unsafe target.move.update(from: source, count: count)
            default:
                preconditionFailure("Unknown operation")
            }
        }
        #if DEBUG
        let diagnostic = String(decoding: result.standardErrorContent, as: UTF8.self)
        #expect(diagnostic.contains("not representable as Int"), "\(diagnostic)")
        #else
        _ = result
        #endif
    }

    @Test(
        arguments: ["array", "contiguous", "inline", "buffer", "mutable-buffer-get", "mutable-buffer-set", "output-first", "output-second"],
        [UInt(Int.max) + 1, UInt.max]
    )
    func `bounded positions fail before delegating to storage`(operation: String, raw: UInt) async throws {
        let result = try await #require(
            processExitsWith: .failure,
            observing: [\.standardErrorContent]
        ) { [operation = operation as String, raw = raw as UInt] in
            let position = Ordinal(raw)
            switch operation {
            case "array":
                precondition([10, 20][position] == 10)
            case "contiguous":
                var values = ContiguousArray([10, 20])
                values[position] = 30
            case "inline":
                var values: InlineArray<2, Int> = [10, 20]
                values[position] = 30
            default:
                var values = [10, 20]
                values.withUnsafeMutableBufferPointer { buffer in
                    let index = Tagged<Int, Ordinal>(position)
                    switch operation {
                    case "buffer":
                        precondition(UnsafeBufferPointer(buffer)[index] == 10)
                    case "mutable-buffer-get":
                        precondition(unsafe buffer[index] == 10)
                    case "mutable-buffer-set":
                        unsafe buffer[index] = 30
                    case "output-first", "output-second":
                        var output = unsafe OutputSpan(buffer: buffer, initializedCount: 2)
                        if operation == "output-first" {
                            output.swapAt(position, Ordinal.zero)
                        } else {
                            output.swapAt(Ordinal.zero, position)
                        }
                        _ = unsafe output.finalize(for: buffer)
                    default:
                        preconditionFailure("Unknown operation")
                    }
                }
            }
        }
        #if DEBUG
        let diagnostic = String(decoding: result.standardErrorContent, as: UTF8.self)
        #expect(diagnostic.contains("not representable as Int"), "\(diagnostic)")
        #else
        _ = result
        #endif
    }
}

#endif
