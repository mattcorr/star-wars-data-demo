# star-wars-data-demo

## Summary

This repo contains a sample **PowerShell** script and various **Pester** tests.

The purpose of the repo is to demonstrate Pester usage for both standard and mocked tests.
The script wraps a Star Wars API site located here: https://swapi-deno.azurewebsites.net

## Files

| Filename | Description|
|---|---|
|StarWarsData.ps1|PowerShell script containing a wrapper for People, Planets and Films|
|StarWarsData.Simple.Tests.ps1|Simple Pester Tests for the script above|
|StarWarsData.Mocked.Tests.ps1|The same tests as Simple, but with a mocked backend for the script above|

## Usage

- Clone this repo locally.
- Ensure you have the latest versions of [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.1) and [Pester](https://pester-docs.netlify.app/docs/introduction/installation) installed.
- It is recommended to use [Visual Studio Code](https://code.visualstudio.com/) as it is the de-facto editor for PowerShell scripts.
- Install the [PowerShell plugin](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell)
- Optionally, you can install a Pester plugin from the Marketplace, but take care as they can be buggy. (Although the [Pester Tests plugin](https://marketplace.visualstudio.com/items?itemName=pspester.pester-test) seems good!)
