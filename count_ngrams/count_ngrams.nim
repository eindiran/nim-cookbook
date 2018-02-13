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
    # This should work like the Python: seq[lower_bound:upper_bound]
    for i in lower_bound..upper_bound-1:
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
        tokens_mut.add("</s>") # Add sentence end tokens
    var num_tokens: int = tokens_mut.len
    for i in 0..num_tokens-1:
        var low_bound: int = i + n
        var high_bound: int = min(low_bound, num_tokens) + 1
        for j in low_bound..high_bound-1:
            var tokens_slice: seq[string] = get_seq_slice(i, j, tokens_mut)
            let current_ngram: string = join(tokens_slice, sep=" ")
            ngram_list.add(current_ngram)
    return ngram_list


proc write_ngram_counts(filename: string, ngram_counts: Table[string, int]): void =
    ## Write an ngram count Table to file
    var out_file = open(filename, fmWrite)
    for ngram in keys(ngram_counts):
        var count: int = ngram_counts[ngram]
        out_file.write(ngram & "\t" & $count & "\n")
    out_file.close()


proc test_build_vocab(): void =
    ## Demonstrate that we can read in a vocab file
    var vocab_table: Table[string, int] = read_vocab("input_file.txt")
    print_kv_pairs(vocab_table)


proc build_test_seq(): seq[string] =
    ## Generate a seq[string] for testing
    var result_seq = newSeq[string]()
    result_seq.add("Zero")
    result_seq.add("One")
    result_seq.add("Two")
    result_seq.add("Three")
    result_seq.add("Four")
    result_seq.add("Five")
    result_seq.add("Six")
    result_seq.add("Seven")
    return result_seq


proc test_unigrams(): void =
    ## Print out info for unigrams
    var test_seq = build_test_seq()
    var unigram_list = generate_ngrams(1, test_seq)
    print_seq_info(unigram_list)


proc test_bigrams(): void =
    ## Print out info for bigrams
    var test_seq = build_test_seq()
    var bigram_list = generate_ngrams(2, test_seq)
    print_seq_info(bigram_list)


proc test_trigrams(): void =
    ## Print out info for trigrams
    var test_seq = build_test_seq()
    var trigram_list = generate_ngrams(3, test_seq)
    print_seq_info(trigram_list)


proc test_4grams(): void =
    ## Print out info for 4-grams
    var test_seq = build_test_seq()
    var four_gram_list = generate_ngrams(4, test_seq)
    print_seq_info(four_gram_list)


proc test_ngrams(): void =
    ## Do unigrams to 4-grams for test_seq
    echo("Running unigrams:\n")
    test_unigrams()
    echo("\nRunning bigrams:\n")
    test_bigrams()
    echo("\nRunning trigrams:\n")
    test_trigrams()
    echo("\nRunning 4-grams:\n")
    test_4grams()
    echo("\nDone!")


proc test_seq_slice(): void =
    ## Test that get_seq_slice behaves as expected
    var test_seq = build_test_seq()
    var test_slice = get_seq_slice(2, 5, test_seq)
    print_seq_info(test_slice)


proc test_write_ngram_counts(): void =
    ## Test our output function
    var output_file: string = "ngram_counts.bigrams"
    var ngram_counts: Table[string, int] = {"<s> Zero": 3,
                                            "Zero One": 2,
                                            "One Two": 1,
                                            "Six Seven": 14}.toTable
    echo("Writing file...")
    write_ngram_counts(output_file, ngram_counts)
    echo("Done!")


when isMainModule:
    proc main =
        ## Main function
        let debug: bool = false
        if debug:
            test_write_ngram_counts()
            test_seq_slice()
            test_build_vocab()
        test_ngrams()
    main()
