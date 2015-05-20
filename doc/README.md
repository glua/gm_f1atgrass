# Voxelate Documentation

The module adds the voxels entity. You spawn it like this:

`
local myVoxels = ents.Create("voxels")
`

This should be done on the server side. You should not try creating, configuring
or interacting with voxels on the client side. They are networked to the client automatically.

Voxels are configured by setting their config variable. Like this:

`
myVoxels.config = {key1 = value1,key2 = value2}
`

Once you configure the voxels, spawn them. You can also change the position of the voxels entity. Changing the rotation is not reccomended.

`
myVoxels:SetPos(Vector(-12800,-12800,0))
myVoxels:Spawn()
`

You cannot change the config settings once the voxels are spawned.

## Config Options

There are a number of config options. None are required, but you're going to have to set some
of them to get anything to appear.

### dimensions
- Type: Vector
- Default: Vector(1,1,1)
This option specifies the dimensions of the system of voxels, in chunks. Chunk sizes are currently hardcoded 16x16x16 blocks, but *this may change*.
You should use integers here, floating point numbers will be truncated. The lower corner of the first chunk will be on the entity's origin. Chunks will grow out in the positive x/y/z directions.

### scale
- Type: Number
- Default: 1
This controls the size of the voxels themselves. The number corrisponds the the width of a single voxel. Leaving this at the default setting is not reccomended. Very small values will probably cause you to crash
if you have physical meshes enabled.

### drawExterior
- Type: Bool
- Default: false
This controls whether meshe faces will generate on the outer bounds of the system of voxels.
You should only ever use it if your voxel system does not fill the whole map. Otherwise leave it off.

### atlasMaterial
- Type: String
- Default: "models/debug/debugwhite"
This is the material that the voxel system will pull textures from. It should be a grid of textures for voxels. It should exist clientside. It must be a VMT, not a PNG.
See the section on atlas setup for more info.

### atlasWidth/atlasHeight
- Type: Number
- Default: 1
These two settings control the dimensions of the grid in the texture atlas. They should match how you design your texture atlas.

### useMeshCollisions
- Type: Bool
- Default: false
Enables mesh collisions. This will cause the server to generate collision meshes as the client generates visual meshes.
This will cause the server to use more memory and spend more time updating chunks.
It will allow physical objects to collide with the system of voxels.
Players, bullets, and other traces will always be able to collide with the voxels.

### voxelTypes
- Type: Table
- Default: {}
A table of voxel types. The keys are block IDs, which can range from 0-255. The values are tables of settings for that specific block type.
See the following section on Voxel Type Options.

## Voxel Type Options

### atlasIndex
- Type: Number
- Default: 0?
The index in the atlas used for the block's texture. Cells in the atlas are numbered in rows from left to right, top to bottom.

## Atlas Setup

The atlas must be a VMT/VTF pair, not a PNG.

Here is a sample VMT:

`
"VertexLitGeneric"
{
	$basetexture TEXTURENAME
}
`

Your atlas texture should have dimensions that are powers of 2. Otherwise it will be resized to a power of 2 and create artifacts.

You can use the "Point Sample" option on the texture if you want a Minecraft-esque look. This may create artifacts at a distance.

You can try disabling MIPMAPS to deal with artifacts, but this will cause similar artifacts as the above option and will look really out of place.
