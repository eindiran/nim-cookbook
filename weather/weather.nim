import strutils
import docopt
import os
import ospaths
import location_handler

let doc = """
weather.nim
Fetch information about the weather.

Usage:
    weather
    weather --loc <loc> [--units <unit>] [--temp | --full]
    weather --zip <zip> [--units <unit>] [--temp | --full]
    weather --help
    weather --version

Options:
    --help      Print this message and exit.
    --version   Print the version number and exit.
    --loc       Set the location string.
    --zip       Set the zip code.
    --temp      Show only the temperature.
    --full      Show the whole week's weather.
    --units     Change the units between 'c' and 'f'.
"""


type TemperatureUnit = enum
    ## Enum representing the units for temp
    Fahrenheit, Celsius


type LocationIdentifier = enum
    ## Use this to set whether Zipcode, Location Name, or IP address
    ## is used to id the locaiton
    LocName, ZipCode, NoneGiven


var
    ## These globals control information returned
    location_id: LocationIdentifier = NoneGiven
    location_str: string = ""
    zip_code: string = ""
    temp: bool = false
    full_week: bool = false
    units: TemperatureUnit = Fahrenheit


proc print_args(): void =
    ## Print out the commandline args; useful for debugging docopt
    if location_id == LocName:
        echo("Location:\t\t", location_str)
    elif location_id == ZipCode:
        echo("Zipcode:\t\t", zip_code)
    else:
        echo("Location:\t\t", "IP Address Lookup")
    echo("Temperature:\t\t", temp)
    echo("Full week?:\t\t", full_week)
    echo("Units:\t\t\t", units)


proc handle_args(): void =
    ## Handle the command-line arguments using docopt
    let args = docopt(doc, version = "weather.nim 1.0")
    if args["--loc"]:
        location_str = $args["<loc>"]
        location_id = LocName
    if args["--zip"]:
        zip_code = $args["<zip>"]
        location_id = ZipCode
    if args["--temp"]:
        temp = true # only show temperature
    if args["--units"]:
        if $args["<unit>"] in @["c", "C", "Celsius", "celsius"]:
            units = Celsius
        # Otherwise default to Fahrenheit
    if args["--full"]:
        full_week = true


proc get_wttrin_url(): string =
    ## Using info in the globals, create a URL for wttr.in
    var wttrin_url: string
    wttrin_url =
        if location_id == LocName:
            handle_location(location_str)
        elif location_id == ZipCode:
            "wttr.in/" & zipcode
        else:
            "wttr.in"
    return wttrin_url
    

proc get_wttrin_data(wttrin_url: string): void =
    ## Make a curl request to the wttrin_url
    var
        cmd_currenttime: string
        wttrin_cmd: string
    # Get time
    cmd_currenttime =
        if location_id == LocName:
            "currenttime -l " & location_str & " --date --dow"
        elif location_id == ZipCode:
            "currenttime -l " & zipcode & " --date --dow"
        else:
            "currenttime --date --dow"
    discard execShellCmd(cmd_currenttime)
    # Display weather
    wttrin_cmd = "curl -s -N " & wttrin_url & "| head -n 7"
    discard execShellCmd(wttrin_cmd)


when isMainModule:
    proc main =
        let DEBUG: bool = false
        handle_args()
        if DEBUG:
            print_args()
            echo("Location URL:\t\t", get_wttrin_url())
            echo("\n\n")
        get_wttrin_data(get_wttrin_url())
    main()
