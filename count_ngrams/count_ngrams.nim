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


proc print_seq_info(input_seq: seq[string]): void =
    ## Debugging function, used to print info about a seq
    echo("Seq is " & $input_seq.len & " elements long.")
    for i in input_seq:
        echo(i)


proc get_seq_slice(lower_bound: int, upper_bound: int, s: seq[string]): seq[string] =
    ## Take as input two seq indices and a seq and return a slice
    var return_slice: seq[string] = newSeq[string]()
    for i in lower_bound..upper_bound:
        try:
            return_slice.add(s[i])
        except IndexError:
            break
    return return_slice


proc generate_ngrams(n: int, tokens: seq[string]): seq[string] =
    ## Generate the list of ngrams from the tokens
    var tokens_mut: seq[string] = tokens # Get a mutable copy
    var ngram_list: seq[string] = newSeq[string]() # New seq for output
    for i in 1..n-1:
        tokens_mut.insert("<s>", 0) # Add sentence start tokens
    var num_tokens: int = tokens_mut.len
    for i in 0..num_tokens:
        var low_bound: int = i + n
        var high_bound: int = min(low_bound, num_tokens) + 1
        for j in low_bound..high_bound:
            var tokens_slice: seq[string] = get_seq_slice(i, j, tokens_mut)
            let current_ngram: string = join(tokens_slice, sep=" ")
            ngram_list.add(current_ngram)
    return ngram_list


when isMainModule:
    proc main =
        ## Main function
        #var vocab_table: Table[string, int] = read_vocab("input_file.txt")
        #print_kv_pairs(vocab_table)
        var my_seq = newSeq[string]()
        my_seq.add("Zero")
        my_seq.add("One")
        my_seq.add("Two")
        my_seq.add("Three")
        my_seq.add("Four")
        my_seq.add("Five")
        my_seq.add("Six")
        my_seq.add("Seven")
        #var my_seq_two = get_seq_slice(2, 5, my_seq)
        #print_seq_info(my_seq_two)
        var my_seq3 = generate_ngrams(2, my_seq)
        print_seq_info(my_seq3)
    main()
