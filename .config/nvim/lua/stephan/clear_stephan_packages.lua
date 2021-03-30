-- this is needed in order to be able to reload my changes
for k, _ in pairs(package.loaded) do
  if string.match(k, "^stephan") then
     package.loaded[k] = nil
  end
end
