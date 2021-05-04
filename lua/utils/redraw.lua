local cmd = vim.api.nvim_command
local loop = vim.loop

local config = {interval=100}
local last = nil
local scheduled = false

local function callback(now)
  last = now or loop.now()
  scheduled = false
  cmd('redrawstatus!')
end

local wrapped = vim.schedule_wrap(callback)
local timer = loop.new_timer()

local function redraw()
  local now = loop.now()

  if last == nil or now - last > config.interval then
    loop.timer_stop(timer)
    callback(now)
  elseif not schedule then
    scheduled = true
    loop.timer_start(timer, config.interval + last - now, 0, wrapped)
  end
end

return {
  config=config,
  redraw=redraw,
}
