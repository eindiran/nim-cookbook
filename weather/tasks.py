from invoke import task, run


@task(name='build_loc')
def build_location(ctx):
    """Build the location_handler submodule of the weather.nim module."""
    print('Building location/location_handler.nim')
    run('cd location && nim compile -d:release location_handler')
    print('Compilation complete.\nInstalling location_handler package.')
    run('cd location && nimble install -y')
    print('location_handler installed.')


@task(name='build_ternary')
def build_ternary(ctx):
    """Build the ternary submodule of the weather.nim module."""
    print('Building ternary/ternary.nim')
    run('cd ternary && nim compile -d:release ternary')
    print('Compilation complete.\nInstalling ternary package.')
    run('cd ternary && nimble install -y')
    print('ternary installed.')


@task(name='build_weather')
def build_weather(ctx):
    """Build the weather.nim module."""
    print('Building weather.nim')
    run('nim compile -d:release weather')
    print('Compilation complete!')


@task(name='build')
def build_all(ctx):
    """Build all submodules for weather.nim."""
    build_location(ctx)
    build_ternary(ctx)
    build_weather(ctx)


@task(name='test_loc')
def test_location(ctx):
    """Run the tests for the location submodule."""
    print('Running tests for the location module.')
    run('cd location && nim compile -d:release location_handler && ./location_handler')


@task(name='test_ternary')
def test_ternary(ctx):
    """Run the tests for the ternary submodule."""
    print('Running tests for the ternary module.')
    run('cd ternary && nim compile -d:release ternary && ./ternary')


@task(name='test')
def test_all(ctx):
    """Run all the tests."""
    test_location(ctx)
    test_ternary(ctx)


@task(name='clean_loc')
def clean_location(ctx):
    """Clean up the build artifacts for the location_handler submodule."""
    print('Cleaning up location_handler.')
    run('cd location && rm -rf nimcache')


@task(name='clean_weather')
def clean_weather(ctx):
    """Clean up the build artifacts for the weather module."""
    print('Cleaning up weather.')
    run('rm -rf nimcache')


@task(name='clean_ternary')
def clean_ternary(ctx):
    """Clean up the build artifacts for the ternary submodule."""
    print('Cleaning up ternary.')
    run('cd ternary && rm -rf nimcache')


@task(name='clean')
def clean_all(ctx):
    """Clean up the build artifacts for all modules."""
    clean_location(ctx)
    clean_ternary(ctx)
    clean_weather(ctx)
    run('rm -rf __pycache__')
    print('All cleaning tasks complete.')
