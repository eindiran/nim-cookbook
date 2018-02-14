# Handle a location str, turning it into a wttr.in URL

proc handle_location*(location_str: string): string =
    ## Takes a location string and returns a location's wttr.in URL
    # Note that these are places that I care about
    # Another user might change this list to suit them
    var loc_url: string = case location_str:
        of "OZ", "GC", "Gold_Coast":
            "wttr.in/gold_coast"
        of "BR", "Brisbane":
            "wttr.in/brisbane"
        of "SY", "Sydney":
            "wttr.in/sydney"
        of "LA", "Los_Angeles":
            "wttr.in/los_angeles"
        of "SF", "San_Francisco":
            "wttr.in/sf"
        of "MP", "Menlo_Park":
            "wttr.in/menlo_park"
        of "MV", "Mountain_View":
            "wttr.in/mountain_view"
        of "SJ", "SJC", "San_Jose":
            "wttr.in/sjc"
        of "OAK", "Oakland":
            "wttr.in/oakland"
        of "BK", "Berkeley":
            "wttr.in/berkeley"
        of "SLC", "Salt_Lake_City":
            "wttr.in/salt_lake_city"
        of "AU", "Austin":
            "wttr.in/austin"
        of "DE", "Denver":
            "wttr.in/denver"
        of "PDX", "Portland":
            "wttr.in/portland"
        of "SEA", "Seattle":
            "wttr.in/seattle"
        of "CHI", "Chicago":
            "wttr.in/chicago"
        of "NY", "NYC", "New_York", "New_York_City":
            "wttr.in/new_york"
        of "BO", "Boston":
            "wttr.in/boston"
        of "DC", "Washington_DC":
            "wttr.in/washington_dc"
        of "OR", "Orlando":
            "wttr.in/orlando"
        of "MI", "Miami":
            "wttr.in/miami"
        of "AM", "Amsterdam":
            "wttr.in/amsterdam"
        of "LO", "London":
            "wttr.in/london"
        of "LI", "Liverpool":
            "wttr.in/liverpool"
        of "PR", "Prague":
            "wttr.in/prague"
        of "PA", "Paris":
            "wttr.in/paris"
        of "BE", "Berlin":
            "wttr.in/berlin"
        of "MO", "Moscow":
            "wttr.in/moscow"
        of "NO", "Novokuznetsk":
            "wttr.in/novokuznetsk"
        of "IS", "Istanbul":
            "wttr.in/istanbul"
        of "RK", "Reykjavik":
            "wttr.in/reykjavik"
        of "TO", "Tokyo":
            "wttr.in/tokyo"
        of "KL", "Kuala_Lumpur":
            "wttr.in/kuala_lumpur"
        of "BJ", "Beijing":
            "wttr.in/beijing"
        of "HK", "Hong_Kong":
            "wttr.in/hong_kong"
        else:
            "wttr.in" # local to the user
    return loc_url


proc test_handle_location(): void =
    ## Run tests on handle_location
    # Inputs
    let location_list = @["OZ", "Brisbane", "Los_Angeles", "SF", "MP",
                          "AM", "Paris", "HK", "KL", "Prague"]
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
                            "wttr.in/prague"]
    # Outputs
    var handled_loc_list = newSeq[string]()
    for i, loc in location_list:
        let result_url = handle_location(loc)
        handled_loc_list.add(result_url)
        echo("Test Case: \"" & loc & "\"\n\tProduced: " &
             result_url & "\n\tExpected: " & correct_answers[i])
    if correct_answers == handled_loc_list:
        echo("All tests passed!")
    else:
        echo("Some tests failed!")


when isMainModule:
    proc main =
        test_handle_location()
    main()
