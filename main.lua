
function love.load()
    walkimages ={
        love.graphics.newImage("assets/base.png"),
        love.graphics.newImage("assets/walk1.png"),
        love.graphics.newImage("assets/walk2.png")
    }

    fallingimage = love.graphics.newImage("assets/falling.png")
    fallingimage:setFilter("nearest","nearest")

    ballonimages = {
        love.graphics.newImage("assets/ballon/blue.png"),
        love.graphics.newImage("assets/ballon/green.png"),
        love.graphics.newImage("assets/ballon/red.png"),
        love.graphics.newImage("assets/ballon/yellow.png")
    }



    bgg = love.graphics.newImage("assets/bg1.png")
    bgg:setFilter("nearest","nearest")
    groundY = love.graphics.getHeight()- bgg:getHeight()*3

    currentFrame = 1
    

    playerX = 250
    playerY = 0
    playerWalkSpeed = 100
    jumping = 0
    tick = 5
    jumpingStatus = 0
    jumpingStatusA = "False"
    ballonTimer = 5
    ballonDraw = 0
    ballonY = 0
    ballonDrawS = 0
    ballonDestory = 0

    score = 0
end


function love.update(dt)
    

    playerImage = walkimages[1]
    playerImage:setFilter("nearest","nearest")
    playerHeight = playerImage:getHeight()*3
    playerWidth = playerImage:getWidth()*3
    
    -- left and right movement
    if love.keyboard.isDown("a") then
        playerX = playerX - playerWalkSpeed*dt
        playerImage = walkAna("Left",dt)
        playerHeight = playerImage:getHeight()*3
        playerWidth = playerImage:getWidth()*3
    elseif love.keyboard.isDown("d") then
        playerX=playerX+playerWalkSpeed*dt
        playerImage = walkAna("Right",dt)
        playerHeight = playerImage:getHeight()*3
        playerWidth = playerImage:getWidth()*3
    end

    -- jumping + ana
    if love.keyboard.isDown("w") and jumpcd == 0 or jumpingStatusA == "True"  then
        local detail = 25
        if jumpingStatus > detail then
            jumpingStatus = 0
            jumpingStatusA = "False"
            jumping = 0

        elseif jumpingStatus <= detail then
            playerY = playerY - 4
            jumpingAna()
            jumpingStatusA = "True"
            jumping = 1
        end
        tick = 0
        jumpcd = 1
    else 
        jumping = 0
        jumpingStatusA = "False"

    end


    -- Player gravity 
    if  groundY > playerHeight+playerY-25 and jumping == 0 then
        tick = tick + 30*dt
        playerY = playerY+((math.floor(tick)^2)+100)*dt
        failing = 1
        playerImage = fallingimage
    elseif not(groundY > playerHeight+playerY-25) then
        jumpcd = 0
    else
        failing = 0
    end



    --ballon stuff
    
    if ballonTimer >= 5 then
        ballonTimer = 0
        ballonTableNumber = love.math.random(1,4)
        ballonTableX = love.math.random(10,800)
        ballonImage = ballonimages[ballonTableNumber]
        ballonImage:setFilter("nearest","nearest")
        ballonDrawS = 1
        ballonY = 0
    else
        ballonTimer = ballonTimer + dt
    end

    if ballonDestory == 1 then
        ballonDrawS = 0
        ballonTimer = 6
    end
    -- ballon go down
    ballonY = ballonY+40*dt



    -- touching check 
    playerTopY = playerY
    playerBottomY = playerY + playerHeight
    playerLeftX = playerX
    playerRightX = playerX + playerWidth

    ballonbottomY = ballonY
    ballonTopY = ballonY+ballonImage:getHeight()*2
    ballonRightX = ballonTableX+30
    ballonLeftX = ballonTableX + ballonImage:getWidth()+30

    touching = checkTouch(playerTopY,playerRightX,playerBottomY,playerLeftX,ballonTopY,ballonRightX,ballonbottomY,ballonLeftX)
    if touching == true then
        ballonDestory = 1
        ballonDrawS = 0
        score = score + 1
    else
        ballonDestory = 0
    end
end



function love.draw()
    love.graphics.rectangle("fill",0,0,800,800)
    love.graphics.draw(playerImage,playerX,playerY,0,3,3)

    love.graphics.draw(bgg,0,bgg:getHeight(),0,5,5)
    love.graphics.draw(bgg,320,bgg:getHeight(),0,5,5)

    --player 
    --love.graphics.rectangle("fill",playerLeftX,playerTopY,10,10)
    --love.graphics.rectangle("fill",playerLeftX,playerBottomY,10,10)
    --love.graphics.rectangle("fill",playerRightX,playerTopY,10,10)
    --love.graphics.rectangle("fill",playerRightX,playerBottomY,10,10)

    --ballon
    --love.graphics.rectangle("line",ballonLeftX,ballonTopY,10,10)
    --love.graphics.rectangle("line",ballonLeftX,ballonbottomY,10,10)
    --love.graphics.rectangle("fill",ballonRightX,ballonTopY,10,10)
    --love.graphics.rectangle("fill",ballonRightX,ballonbottomY,10,10)

    love.graphics.print(score,20,500,0,3,3)

    if ballonDrawS == 1 then
        love.graphics.draw(ballonImage,ballonTableX,ballonY,0,3,3)
    end
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


function jumpingAna()
    love.draw()
    jumpingStatus = jumpingStatus+1

end


function checkTouch(T,R,B,L,T2,R2,B2,L2)

    if R > L2 and L < R2 and B > T2 and T < B2 then
        return true
    end


end