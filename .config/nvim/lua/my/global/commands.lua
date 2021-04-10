my.state.commands = {}

my.command = function(conf)
  if (conf.cmd == nil) then
    error("my.command: cmd is required")
  end
  if (conf.description == nil) then
    error("my.command: description is required")
  end

  my.state.commands[conf.cmd] = conf
end
