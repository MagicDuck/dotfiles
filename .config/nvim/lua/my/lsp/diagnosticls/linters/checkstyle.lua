--java -Dconfig_loc=./config/checkstyle -jar ~/checkstyle/checkstyle-9.2.1-all.jar -c ./gradle/xMattersFormatAndImportChecks.xml ./src/main/java/com/xmatters/xm/service/EventService.java

-- TODO (sbadragan): make this act differently depending on the project we are in, ondemand vs xm-api
return {
  command = vim.fn.expand("~/.jenv/versions/11/bin/java"),
  -- rootPatterns = {"config/checkstyle"},
  debounce = 100,
  args = {
    "-jar",
    vim.fn.expand("~/checkstyle/checkstyle-9.2.1-all.jar"),
    "-f",
    "sarif",
    "-c",
    "./gradle/xMattersFormatAndImportChecks.xml",
    "%filepath"
  },
  isStdout = true,
  isStderr = false,
  sourceName = "checkstyle",
  parseJson = {
    errorsRoot = "runs.results",
    line = "locations[0].physicalLocation.region.startLine",
    column = "locations[0].physicalLocation.region.startColumn",
    endLine = "locations[0].physicalLocation.region.startLine",
    endColumn = "locations[0].physicalLocation.region.startColumn",
    message = "[checkstyle] ${message.text} (${ruleId})",
    security = "level"
  },
  securities = {
    [2] = "error",
    [1] = "warning"
  }
}
