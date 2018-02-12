# Nim Cookbook
# Recipe 4 -- Number Guessing Game

import random
import parseutils
import times # Use this to get the tickcount


proc gen_random_num(): int =
    ## Return an integer between 1 and 99.
    let time = int64(times.epochTime() * 1_000_000_000)
    randomize(time) # Seed the RNG with the current tickcount
    return random(1..100)


when isMainModule:
    proc main =
        ## Generate a random number then have the user guess it.
        var rand_num: int = gen_random_num()
        var guess_num: int
        echo "Guess a number:\t"
        let guess_str: string = readLine(stdin)
        discard parseInt(guess_str, guess_num)
        while true:
            if guess_num == rand_num:
                echo "Correct!"
                return
            elif guess_num < rand_num:
                echo "Guess a bigger number!"
                let guess_str: string = readLine(stdin)
                discard parseInt(guess_str, guess_num)
            else:
                echo "Guess a smaller number!"
                let guess_str: string = readLine(stdin)
                discard parseInt(guess_str, guess_num)
    main()
