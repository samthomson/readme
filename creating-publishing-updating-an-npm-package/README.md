# creating, publishing, and updating an npm package

- have a folder with a package.json file
- package.json file should have a **name** and **version** property

## creating a package

Ensure machine is authd to npm via `npm adduser` command

- search on npm to check name is free
- add required package.json fields:
  - name
  - version
- add optional package.json fields:
  - main
  - description
  - keywords
  - license
  - repository
  - bugs
  - author
- add a prepublish package script: `yarn run lint && yarn run test && yarn run build`
- `npm publish`

## updating a package

- ensure the package.json version property is updated accordingly (major minor patch release?)
- `npm publish`
