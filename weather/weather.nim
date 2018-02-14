import strutils
import docopt
import location_handler

let doc = """
weather.nim
Fetch information about the weather.

Usage:
    weather
    weather --loc <loc>
    weather --zip <zip>
    weather --temp...
    weather --full...
    weather --units <units>...
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

var
    ## These globals control information returned
    location_str: string = ""
    zip_code: string = ""
    temp: bool = false
    full_week: bool = false
    units: TemperatureUnit = Fahrenheit


proc handle_args(): void =
    ## Handle the command-line arguments using docopt
    let args = docopt(doc, version = "weather.nim 1.0")
    if args["--loc"]:
        location_str = $args["<loc>"]
    if args["--zip"]:
        zip_code = $args["<zip>"]
    if args["--temp"]:
        temp = true # only show temperature
    if args["--units"]:
        if $args["<unit>"] in @["c", "C", "Celsius", "celsius"]:
            units = Celsius
        # Otherwise default to Fahrenheit
    if args["--full"]:
        full_week = true
    echo("Location:\t", location_str)
    echo("Zipcode:\t", zip_code)
    echo("Temperature:\t", temp)
    echo("FW:\t", full_week)
    echo("Units:\t", units)
    

when isMainModule:
    proc main =
        handle_args()
    main()
