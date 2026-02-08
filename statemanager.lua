local statemanager = {}
local states = {}

function statemanager.switch(state) 
    -- 1. Exit old state
    if states[#states] and states[#states].exit then
        states[#states]:exit()
    end

    table.insert(states, state) 

    if state.enter then
        state:enter()
    end
end

function statemanager.pop()
    local oldState = table.remove(states)
    if oldState and oldState.exit then oldState:exit() end
end

function statemanager.update(dt)
    if states[#states] and states[#states].update then
        states[#states]:update(dt)
    end
end

function statemanager.draw()
    for _, state in ipairs(states) do
        -- Check if draw exists before calling it to be safe
        if state.draw then state:draw() end
    end
end

function statemanager.mousepressed(x, y, button)
    if states[#states] and states[#states].mousepressed then
        states[#states]:mousepressed(x, y, button)
    end
end

function statemanager.current()
    return states[#states]
end

return statemanager