proc compute_avg_line_len(): float =
    ## Compute the average number of chars per line.
    var
        sum: int = 0
        count: int = 0

    for line in stdin.lines:
        sum += line.len
        count += 1

    echo("Total chars:\t", sum)
    echo("Total lines:\t", count)

    if count > 0:
        return sum / count
    else:
        return 0.0

when isMainModule:
    proc main = 
        ## Perform computation of line length on stdin
        var line_avg: float = compute_avg_line_len()
        echo("Average line length:\t", line_avg)
    main()
