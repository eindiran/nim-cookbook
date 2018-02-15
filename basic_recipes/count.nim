# Nim Cookbook
# Recipe Five -- Counting controlled by the user.

import parseutils


when isMainModule:
    proc main =
        ## Counting controlled by inputs on stdin
        var
            max, min, count_by: int
        # Get max
        echo "Enter the max:\t"
        let max_str: string = readLine(stdin)
        discard parseInt(max_str, max)
        # Get min
        echo "Enter the min:\t"
        let min_str: string = readLine(stdin)
        discard parseInt(min_str, min)
        # Get count_by
        echo "Enter the number to count by:\t"
        let count_by_str: string = readLine(stdin)
        discard parseInt(count_by_str, count_by)
        echo "\n================================\n"
        # Run countup
        for i in countup(min, max, step=count_by):
            echo i
    main()

