
function love.load()
    walkimages ={
        love.graphics.newImage("assets/base.png"),
        love.graphics.newImage("assets/walk1.png"),
        love.graphics.newImage("assets/walk2.png")
    }
    bgg = love.graphics.newImage("assets/bg1.png")
    bgg:setFilter("nearest","nearest")
    groundY = love.graphics.getHeight()- bgg:getHeight()*3

    currentFrame = 1
    

    playerX = 250
    playerY = 0
    playerWalkSpeed = 100
    
end


function love.update(dt)
    

    playerImage = walkimages[1]
    playerImage:setFilter("nearest","nearest")
    playerHeight = playerImage:getHeight()*3
    if love.keyboard.isDown("a") then
        playerX = playerX - playerWalkSpeed*dt
        playerImage = walkAna("Left",dt)
        playerHeight = playerImage:getHeight()*3
    elseif love.keyboard.isDown("d") then
        playerX=playerX+playerWalkSpeed*dt
        playerImage = walkAna("Right",dt)
        playerHeight = playerImage:getHeight()*3
    end


    if  groundY > playerHeight+playerY-25 then
        playerY = playerY+100*dt
    end

end


function love.draw()

    love.graphics.rectangle("fill",0,0,800,800)
    love.graphics.draw(playerImage,playerX,playerY,0,3,3)

    love.graphics.draw(bgg,0,bgg:getHeight(),0,5,5)
    love.graphics.draw(bgg,320,bgg:getHeight(),0,5,5)
end





function walkAna(Direction,dt)
    currentFrame = currentFrame + dt*15
    RcurrentFrame = math.floor(currentFrame)
    if Direction == "Left" then
        if RcurrentFrame == 2 then
            RcurrentFrame = 3
        end
    elseif Direction == "Right" then
        if RcurrentFrame == 3 then
            RcurrentFrame = 1
        end
    end
    if RcurrentFrame >=4 then
        currentFrame = 1
        RcurrentFrame = 1
    end


    local image = walkimages[math.floor(RcurrentFrame)]
    image:setFilter("nearest","nearest")
    return image
end
