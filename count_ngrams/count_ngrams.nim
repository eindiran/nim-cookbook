import tables
import strutils

proc read_vocab(vocab_file: string): Table[string, int] =
    ## Generate a vocab table using the vocabulary file as input
    var vocab_table: Table[string, int] = initTable[string, int]()
    for line in lines vocab_file:
        var word: string = line.rsplit("\t")[0]
        if hasKey(vocab_table, word): # Emulate a defaultdict
            vocab_table[word] += 1
        else:
            vocab_table[word] = 1
    return vocab_table


proc print_keys(input_table: Table[string, int]): void =
    ## Debugging function, used to print the keys in a table.
    var i: int = 0
    for key in keys[string](input_table):
        echo("Key ", i, ": ", key)
        inc(i)


proc print_kv_pairs(input_table: Table[string, int]): void =
    ## Debugging function, used to print the key-value pairs in a table.
    var i: int = 0
    for key in keys[string](input_table):
        var val: int = input_table[key]
        echo("Index: ", i, "\tKey: ", key, "\n\t\tValue: ", val, "\n")
        inc(i)


when isMainModule:
    proc main =
        ## Main function
        var vocab_table: Table[string, int] = read_vocab("input_file.txt")
        print_kv_pairs(vocab_table)
    main()
