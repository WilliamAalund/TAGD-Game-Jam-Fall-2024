## General Documentation

This is the general documentation file. This file will be the primary source of information about the project.

Table of contents:
	Overview
		Project Name
		Description
		Goals
		Technical Specifications
	
	Directories
		Code
			Entities
			Levels
			Scripts
			Tests
				Audio
				Pathfinding
				Player
				Visuals
			Tools
			UI
		Documentation
		Plugins
		Resources
			Meshes
				Placeholders

### Overview

## Project Name
Starfighter in Training

## Description
You are a star fighter piloting an advanced spaceship to defeat aliens and save your planet. The game is an arcade style third person shooter with dogfighting mechanics.

## Goals
This game is Team 24's submission to the Texas Aggie Game Developers Fall 2024 game jam. Our goal is to produce a game that is polished, highly replayable, but most of all, fun and engaging.

## Technical Specifications
NOT TRUE ANYMORE All 3D models, meshes, and scenes will face in the positive Z direction. This is so basis manipulation is consistent and easy to do.
The above specification needs to change. the look_at() function orients objects to the local -Z axis. In order to take advantage of this function. Assets will need to face in tht -Z direction.

### Player
In the player, each child handles different aspects of the overall scene. The player node is primarily responsible distributing information between each of the nodes. Some important details about the sub nodes are detailed below.
The Ship node is responsible for detecting if the player has left the PlayBoundary scene. The PlayBoundary Scene will call a function on the ship when it is exited.
The crosshair position on the screen is determined by using three different markers, a far marker, a marker on a spring arm, and a close marker. The springarm marker is only used sometimes to reduce calculations, as there was a lot of lag occurring when the spring arm was set to a long length.

## Directories

# Code
This directory is where the bulk of the project will be located. It contains scripts, entities, scenes, 



# Documentation
This will be where information about implementation details will be. 
For projects without anyone else, this does not need to be particulaly long.
Documentation is important so that odd implementation details can be accounted for. 
Messy code that is dependent on other pieces of code should have their dependencies described, so that future efforts can result in a solution quicker.
Documentation will be organized according to directory structure, so finding details on a subject is easy to do.

# Plugins
This is where plugins will be stored. Keeping plugins organized and separate from the code base is good practice.

# Resources
This is where all assets, such as sprites, 3D models, textures, sound effects, music, and UI elements will be stored. 

## Placeholder
These are meshes that are usually created in Godot, and are used as a substitude to a finished design.
