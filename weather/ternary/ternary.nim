## Adds a ternary operator to Nim

type BranchPair[T] = object
    ## Base of the ternary operator.
    then, otherwise: T


proc `!`*[T](a, b: T): BranchPair[T] {.inline.} =
    ## The '!' operator for dividing a BranchPair.
    BranchPair[T](then: a, otherwise: b)


template `?`*[T](cond: bool; p: BranchPair[T]): T =
    ## The '?' operator itself.
    (if cond: p.then else: p.otherwise)


proc test_ternary_operator(): void =
    ## Run tests on the operator
    echo("(true ? 3 ! 4) -->\t", (true ? 3 ! 4))
    echo("(false ? 3 ! 4) -->\t", (false ? 3 ! 4))
    echo("((1 + 1 == 2) ? \"Hello\" ! \"World\") -->\t", ((1+1==2) ? "Hello" ! "World"))
    echo("((1 + 1 == 1) ? \"Hello\" ! \"World\") -->\t", ((1+1==1) ? "Hello" ! "World"))


when isMainModule:
    proc main =
        ## When this is the main module, run the tests.
        test_ternary_operator()
    main()
