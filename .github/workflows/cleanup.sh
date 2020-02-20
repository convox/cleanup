name: release
on:
  push:
    branches: ["*"]
jobs:
  cleanup:
    runs-on: ubuntu-latest
    steps:
    - name: checkout
      uses: actions/checkout@v1
    - name: dependencies
      run: dependencies.sh