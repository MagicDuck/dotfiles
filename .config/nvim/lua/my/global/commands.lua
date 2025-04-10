my.state.commands = {}

my.command = function(conf)
  if conf.cmd == nil then
    print('my.command: cmd is required')
    return
  end
  if conf.description == nil then
    print('my.command: description is required')
    return
  end

  if my.state.commands[conf.cmd] ~= nil then
    P(conf)
    print('command: duplicate command detected!')
  end
  my.state.commands[conf.cmd] = conf
end
