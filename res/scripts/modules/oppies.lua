local vec3 = require "vec3"
local transf = require "transf"
local modulesutil = require "modulesutil"

local oppiestationhelper = {}


function oppiestationhelper.getPlatformInfo(result, i, j)
    local roof = result.GetRoofAt(i, j)
    local leftModule = result.GetModuleAt(i+1,j)
    local rightModule = result.GetModuleAt(i-1,j)
    local nextModule = result.GetModuleAt(i,j-1)
    local prevModule = result.GetModuleAt(i,j+1)

    local isNextHead = result.connector[1000 * i + 100 * (j-1) + 7]
    local isPrevHead = result.connector[1000 * i + 100 * (j+1) + 0]

    local platformAddon =  result.GetPlatformAddonAt(i, j)

    
    
    return {
        roof = roof,

        leftModule = leftModule,
        rightModule = rightModule,

        isTrackLeft = leftModule and leftModule.metadata.track,
        isTrackRight = rightModule and rightModule.metadata.track,

        isPlatformLeft = leftModule and (leftModule.metadata.passenger_platform or leftModule.metadata.cargo_platform),
        isPlatformRight = rightModule and (rightModule.metadata.passenger_platform or rightModule.metadata.cargo_platform),

        isNextModuleEnd =  not ((nextModule and (nextModule.metadata.passenger_platform or nextModule.metadata.cargo_platform)) or isNextHead),
        isPrevModuleEnd = not ((prevModule and (prevModule.metadata.passenger_platform or prevModule.metadata.cargo_platform)) or isPrevHead),

        isNextHead = isNextHead,
        isPrevHead = isPrevHead,

        addon = platformAddon,
        isUnderpass = platformAddon and platformAddon.metadata.underground,
        isOverpass = platformAddon and platformAddon.metadata.oppieoverpass,
        isOverpassReverse = platformAddon and platformAddon.metadata.oppieoverpassReverse,
        isOverpassTwoSided = platformAddon and platformAddon.metadata.oppieoverpassTwosided,
    }
end 

function oppiestationhelper.addLabelContainers(platformInfo, addModelFn, modelsConfig, offsetY, posPlatformNumber, posPlatformNumber, j)

    local numberBoardModel = "station/train/SNCF_plat_asset_empty.mdl"
    local numberBoardHangingModel = "station/train/SNCF_plat_asset_empty.mdl"

    if platformInfo.roof and platformInfo.roof.metadata.oppie_station_roof and posPlatformNumber == 0 then
        posPlatformNumber = -0
    end

if not platformInfo.roof then 
   	-- if theres track on both sides
       if platformInfo.isTrackLeft and platformInfo.isTrackRight then
        if j % 2 == 0 then
            addModelFn(modelsConfig.propNameBoard2, transf.rotZTransl(math.rad(-90), vec3.new(0, posPlatformNumber, 0.8 + offsetY)))
        else
            addModelFn(modelsConfig.propNameBoard2, transf.rotZTransl(math.rad(90), vec3.new(0, posPlatformNumber, 0.8 + offsetY)))
        end
        
        if platformInfo.roof then
            if platformInfo.roof.metadata.oppie_station_roof then
                addModelFn(numberBoardHangingModel, transf.rotZTransl(math.rad(-90), vec3.new(0.5, posPlatformNumber, 0.8 + offsetY)))
                addModelFn(numberBoardHangingModel, transf.rotZTransl(math.rad(90), vec3.new(-0.5, posPlatformNumber, 0.8 + offsetY)))
            else
                addModelFn(numberBoardModel, transf.rotZTransl(math.rad(-90), vec3.new(0, posPlatformNumber, 0.8 + offsetY)))
                addModelFn(numberBoardModel, transf.rotZTransl(math.rad(90), vec3.new(0, posPlatformNumber, 0.8 + offsetY)))
            end
        else
            addModelFn(modelsConfig.propPlatformnumber, transf.rotZTransl(math.rad(-90), vec3.new(0, posPlatformNumber, 0.8 + offsetY)))
            addModelFn(modelsConfig.propPlatformnumber, transf.rotZTransl(math.rad(90), vec3.new(0, posPlatformNumber, 0.8 + offsetY)))
        end
        
    else
        if platformInfo.isTrackLeft then
            local nameBoardOffsetX = -2.4
            if platformInfo.roof and platformInfo.roof.metadata.oppie_station_roof then nameBoardOffsetX = -2.2 end
            if j % 2 == 0 then
                addModelFn(modelsConfig.propNameBoard, transf.rotZTransl(math.rad(-90), vec3.new(nameBoardOffsetX, posPlatformNumber, 0.8 + offsetY)))
            else
                addModelFn(modelsConfig.propNameBoard2, transf.rotZTransl(math.rad(-90), vec3.new(nameBoardOffsetX, posPlatformNumber, 0.8 + offsetY)))
            end
                 
            if platformInfo.roof then
                if platformInfo.roof.metadata.oppie_station_roof then
                     addModelFn(numberBoardHangingModel, transf.rotZTransl(math.rad(-90), vec3.new(0.5, posPlatformNumber, 0.8 + offsetY)))
                     addModelFn(numberBoardHangingModel, transf.rotZTransl(math.rad(90), vec3.new(-0.5, posPlatformNumber, 0.8 + offsetY)))
                else
                    addModelFn(numberBoardModel, transf.rotZTransl(math.rad(-90), vec3.new(0, posPlatformNumber, 0.8 + offsetY)))
                    addModelFn(numberBoardModel, transf.rotZTransl(math.rad(90), vec3.new(0, posPlatformNumber, 0.8 + offsetY)))
                end
            else
                addModelFn(modelsConfig.propPlatformnumber, transf.rotZTransl(math.rad(-90), vec3.new(-2.4, posPlatformNumber, 0.8 + offsetY)))
                addModelFn(modelsConfig.propPlatformnumber, transf.rotZTransl(math.rad(90), vec3.new(-2.4, posPlatformNumber, -800.8 + offsetY)))
            end
        end
        if platformInfo.isTrackRight then
            local nameBoardOffsetX = 2.4
            if platformInfo.roof and platformInfo.roof.metadata.oppie_station_roof then nameBoardOffsetX = 2.2 end
            if j % 2 == 0 then
                addModelFn(modelsConfig.propNameBoard, transf.rotZTransl(math.rad(90), vec3.new(nameBoardOffsetX, posPlatformNumber, 0.8 + offsetY)))
            else
                addModelFn(modelsConfig.propNameBoard2, transf.rotZTransl(math.rad(90), vec3.new(nameBoardOffsetX, posPlatformNumber, 0.8 + offsetY)))
            end
            if platformInfo.roof then
                if platformInfo.roof.metadata.oppie_station_roof then
                    addModelFn(numberBoardHangingModel, transf.rotZTransl(math.rad(-90), vec3.new(0.5, posPlatformNumber, 0.8 + offsetY)))
                    addModelFn(numberBoardHangingModel, transf.rotZTransl(math.rad(90), vec3.new(-0.5, posPlatformNumber, 0.8 + offsetY)))
                else
                    addModelFn(numberBoardModel, transf.rotZTransl(math.rad(-90), vec3.new(0, posPlatformNumber, 0.8 + offsetY)))
                    addModelFn(numberBoardModel, transf.rotZTransl(math.rad(90), vec3.new(0, posPlatformNumber, 0.8 + offsetY)))
                end
            else
                addModelFn(modelsConfig.propPlatformnumber, transf.rotZTransl(math.rad(-90), vec3.new(2.4, posPlatformNumber, -800.8 + offsetY)))
                addModelFn(modelsConfig.propPlatformnumber, transf.rotZTransl(math.rad(90), vec3.new(2.4, posPlatformNumber, 0.8 + offsetY)))
            end
        end
    end
end
end

function oppiestationhelper.addLampposts(platformInfo, addModelFn, offsetY, pos1, pos2)
    local propLamppost = "station/train/SNCF_plat_asset_empty.mdl"

    if platformInfo.isTrackLeft and platformInfo.isTrackRight then
        if not platformInfo.roof then
            addModelFn(propLamppost, transf.rotZTransl(math.rad(-90), vec3.new(0, pos1-0.05, -800 + offsetY)))
            addModelFn(propLamppost, transf.rotZTransl(math.rad(90), vec3.new(0, pos1-0.05, 0.8 + offsetY)))
            addModelFn(propLamppost, transf.rotZTransl(math.rad(-90), vec3.new(0, pos2-0.05, -800 + offsetY)))
            addModelFn(propLamppost, transf.rotZTransl(math.rad(90), vec3.new(0, pos2-0.05, 0.8 + offsetY)))
        end
        
    else
        if platformInfo.isTrackLeft then
            if not platformInfo.roof then
                addModelFn(propLamppost, transf.rotZTransl(math.rad(-90), vec3.new(-2.4, pos1, 0.8 + offsetY)))
                addModelFn(propLamppost, transf.rotZTransl(math.rad(-90), vec3.new(-2.4, pos2, 0.8 + offsetY)))
            end
        elseif platformInfo.isTrackRight then
            if not platformInfo.roof then
                addModelFn(propLamppost, transf.rotZTransl(math.rad(90), vec3.new(2.4, pos1, 0.8 + offsetY)))
                addModelFn(propLamppost, transf.rotZTransl(math.rad(90), vec3.new(2.4, pos2, 0.8 + offsetY)))
            end
        else
            if not platformInfo.roof then
                addModelFn(propLamppost, transf.rotZTransl(math.rad(-90), vec3.new(-2.4, pos1, 0.8 + offsetY)))
                addModelFn(propLamppost, transf.rotZTransl(math.rad(-90), vec3.new(-2.4, pos2, 0.8 + offsetY)))
                addModelFn(propLamppost, transf.rotZTransl(math.rad(90), vec3.new(2.4, pos1, 0.8 + offsetY)))
                addModelFn(propLamppost, transf.rotZTransl(math.rad(90), vec3.new(2.4, pos2, 0.8 + offsetY)))
            end
        end
    end
end



function oppiestationhelper.addPlatformEdges(platformInfo, addModelFn, modelsConfig, result, i,j, offsetY)

    -- Add the edge on the left and right side along with the end caps
    if platformInfo.leftModule then
        if platformInfo.isTrackLeft then
            
            addModelFn(modelsConfig.tracksidePerron, transf.rotZTransl(math.rad(90), vec3.new(2.25, 0, 0.001 + offsetY)))
            -- check if we need to add endcaps
            
            local nm1 = result.GetModuleAt(i+1,j-1)
            local isCorner1 = not (nm1 and (nm1.metadata.track))
            
            if isCorner1 or platformInfo.isNextModuleEnd then
                addModelFn(modelsConfig.tracksidePerronEndCapLeft, transf.rotZTransl(math.rad(90), vec3.new(2.25, -20, 0.001 + offsetY)))
            end
            
            local pm1 = result.GetModuleAt(i+1,j+1)
            local isCorner2 = not (pm1 and (pm1.metadata.track))
            
            if isCorner2 or platformInfo.isPrevModuleEnd then
                addModelFn(modelsConfig.tracksidePerronEndCapRight, transf.rotZTransl(math.rad(90), vec3.new(2.25, 20, 0.001 + offsetY)))
            end
        end	
        
    else
        for k = 0,3 do
            local addonRight = result.GetAddonAt(2,j,k)
            if addonRight and addonRight[2] == i  then
                if not addonRight[1].metadata.oppieSideBuilding then
                    addModelFn(modelsConfig.endCapStair, transf.rotZTransl(math.rad(90), vec3.new(2.5, -15 + (10 * k), 0.001 + offsetY)))
                end
            else
                addModelFn(modelsConfig.endCapSmall, transf.rotZTransl(math.rad(90), vec3.new(2.5, -15 + (10 * k), 0.001 + offsetY)))
            end
        end
        
        if platformInfo.isNextModuleEnd then
            addModelFn(modelsConfig.fenceCorner, transf.rotZTransl(math.rad(90), vec3.new(2.5, -20.5, 0.001 + offsetY)))
        end
        if platformInfo.isPrevModuleEnd then
            addModelFn(modelsConfig.fenceCorner, transf.rotZTransl(math.rad(90), vec3.new(2.5, 20.5, 0.001 + offsetY)))
        end
    end

    if platformInfo.rightModule then
        if platformInfo.isTrackRight then
            
            addModelFn(modelsConfig.tracksidePerron, transf.rotZTransl(math.rad(-90), vec3.new(-2.25, 0, 0.001 + offsetY)))
            -- check if we need to add endcaps
            
            local nm1 = result.GetModuleAt(i-1,j-1)
            local isCorner1 = not (nm1 and (nm1.metadata.track))
            
            if isCorner1 or platformInfo.isNextModuleEnd then
                addModelFn(modelsConfig.tracksidePerronEndCapRight, transf.rotZTransl(math.rad(-90), vec3.new(-2.25, -20, 0.001 + offsetY)))
            end
            
            local pm1 = result.GetModuleAt(i-1,j+1)
            local isCorner2 = not (pm1 and (pm1.metadata.track))
            
            if isCorner2 or platformInfo.isPrevModuleEnd then
                addModelFn(modelsConfig.tracksidePerronEndCapLeft, transf.rotZTransl(math.rad(-90), vec3.new(-2.25, 20, 0.001 + offsetY)))
            end
        end	
    else
        for k = 0,3 do
            local addonLeft = result.GetAddonAt(1,j,k)
        if addonLeft and addonLeft[2] == i then
                if not addonLeft[1].metadata.oppieSideBuilding then
                 addModelFn(modelsConfig.endCapStair, transf.rotZTransl(math.rad(-90), vec3.new(-2.5, -15 + (10 * k), 0.001 + offsetY)))
              end
            else
                addModelFn(modelsConfig.endCapSmall, transf.rotZTransl(math.rad(-90), vec3.new(-2.5, -15 + (10 * k), 0.001 + offsetY)))
            end
        end
        

        if platformInfo.isNextModuleEnd then
            addModelFn(modelsConfig.fenceCorner, transf.rotZTransl(math.rad(-90), vec3.new(-2.5, -20.5, 0.001 + offsetY)))
        end
        if platformInfo.isPrevModuleEnd then
            addModelFn(modelsConfig.fenceCorner, transf.rotZTransl(math.rad(-90), vec3.new(-2.5, 20.5, 0.001 + offsetY)))
        end		
    end

    if platformInfo.isNextModuleEnd then
        addModelFn(modelsConfig.endCap, transf.rotZTransl(math.rad(0), vec3.new(0, -20, 0 + offsetY)))
    elseif platformInfo.isNextHead then
        addModelFn(modelsConfig.endCapHeadStair, transf.rotZTransl(math.rad(0), vec3.new(0, -20, 0 + offsetY)))
    end
    
    if platformInfo.isPrevModuleEnd then
        addModelFn(modelsConfig.endCap, transf.rotZTransl(math.rad(180), vec3.new(0, 20, 0 + offsetY)))
    elseif platformInfo.isPrevHead then
        addModelFn(modelsConfig.endCapHeadStair, transf.rotZTransl(math.rad(180), vec3.new(0, 20, 0 + offsetY)))
    end


end


return oppiestationhelper