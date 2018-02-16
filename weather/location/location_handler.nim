# Handle a location str, turning it into a wttr.in URL
import tables
import strutils


const config_file = "location_list.config"


proc handle_location*(location_str: string): string =
    ## Takes a location string and returns a location's wttr.in URL
    # Note that these are places that I care about
    # Another user might change this list to suit them
    var 
        location_dict: Table[string, string] = initTable[string, string]()
        loc_url: string = ""

    for line in lines config_file:
        var words: seq[string] = split(line, maxsplit=1)
        try:
            add(location_dict, words[0], words[1])
        except IndexError:
            stderr.writeLine("Error: incorrect formatting in ", config_file)
            continue
    if has_key(location_dict, location_str):
        loc_url = location_dict[location_str]
    else:
        loc_url = "wttr.in"
    return loc_url


proc test_handle_location(): void =
    ## Run tests on handle_location
    # Inputs
    let location_list = @["OZ", "Brisbane", "Los_Angeles", "SF", "MP",
                          "AM", "Paris", "HK", "KL", "Prague", "IS",
                          "", "NOT_IN_LIST"]
    # Comparisons
    let correct_answers = @["wttr.in/gold_coast",
                            "wttr.in/brisbane",
                            "wttr.in/los_angeles",
                            "wttr.in/sf",
                            "wttr.in/menlo_park",
                            "wttr.in/amsterdam",
                            "wttr.in/paris",
                            "wttr.in/hong_kong",
                            "wttr.in/kuala_lumpur",
                            "wttr.in/prague",
                            "wttr.in/istanbul",
                            "wttr.in",
                            "wttr.in"]
    # Outputs
    var handled_loc_list = new_seq[string]()
    for i, loc in location_list:
        let result_url = handle_location(loc)
        handled_loc_list.add(result_url)
        echo("Test Case: \"" & loc & "\"\n\tProduced: " &
             result_url & "\n\tExpected: " & correct_answers[i])
    if correct_answers == handled_loc_list:
        echo("All tests passed!")
    else:
        echo("Some tests failed!")


when is_main_module:
    proc main =
        test_handle_location()
    main()
