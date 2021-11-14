# CLIvia generator
## How to play!

Put in the terminal ruby trivia_generator.rb

## Before starting!

1. Create a new folder with the project name and open it from VS Code

## If on Linux/MacOS

2. From the VS Code terminal run the next docker command

```powershell
docker container run \
--name ruby \
-it \
-v $(pwd):/app \
-v ssh:/root/.ssh \
-v bundle:/usr/local/bundle \
-e GIT_USER_NAME=<your_username> \
-e GIT_USER_EMAIL=<your_email> \
--rm \
codeableorg/ruby
```

## If on Windows

2. From the VS Code terminal, select Powershell terminal, then run the next docker command

```powershell
docker container run \
--name ruby \
-it \
-v ${PWD}:/app \
-v ssh:/root/.ssh \
-v bundle:/usr/local/bundle \
-e GIT_USER_NAME=<your_username> \
-e GIT_USER_EMAIL=<your_email> \
--rm \
codeableorg/ruby
```

## Then

3. Clone the repository of your work team

```powershell
$ git clone git@github.com:codeableorg/clivia-generator-xxx.git .
```

4.  Run some initialization scripts

```powershell
$ bootstrap
```

5.  Install some necessary gems for rubocop to work properly

```powershell
$ bundle install
```

ready, you can work on your project!

Looking for the project instructions? Find them on [this notion doc](https://ableco.notion.site/Individual-CLIvia-generator-87e1fd914fe44580aab29f14abae1a04)

To disable temporarily any Rubocop convention:

```
# rubocop:disable Metrics/AbcSize
def complex_and_irreducible_method(that, receive, a, lot, of, params)
  ...
  ...
  ...
end
# rubocop:enable Metrics/AbcSize
```

To disable them, use the convention that Rubocop is complaining about. _Metrics/AbcSize_ is just an example.
