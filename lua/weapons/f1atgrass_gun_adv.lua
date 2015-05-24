AddCSLuaFile()

SWEP.PrintName = "VOXGUN#"

SWEP.UseHands = true
SWEP.WorldModel = "models/weapons/c_SMG1.mdl"
SWEP.ViewModel = "models/weapons/c_SMG1.mdl"

SWEP.Primary.Automatic = true
SWEP.Secondary.Automatic = true

function SWEP:Initialize()
	self.next_reload=0

	if SERVER then
		self.point_selected = false
	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("Vector",0,"P1")
	self:NetworkVar("Vector",1,"P2")
end

function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end

	self:EmitSound( "ambient/machines/teleport1.wav" )

	if SERVER then
		local tr = self.Owner:GetEyeTrace()
		VOXL:setRegionAt(self:GetP1(),self:GetP2(),0)
	end

	self:SetNextPrimaryFire(CurTime()+1)
end

function SWEP:SecondaryAttack()
	if not IsFirstTimePredicted() then return end

	self:EmitSound( "ambient/machines/teleport1.wav" )

	if SERVER then
		local tr = self.Owner:GetEyeTrace()
		VOXL:setRegionAt(self:GetP1(),self:GetP2(),self.Owner:GetInfoNum("voxl_brush_mat",5))
	end
	self:SetNextSecondaryFire(CurTime()+1)
end

function SWEP:Reload()
	if not IsFirstTimePredicted() then return end

	if CurTime()>self.next_reload then
		self:EmitSound( "buttons/button15.wav" )

		if SERVER then
			local tr = self.Owner:GetEyeTrace()

			if self.point_selected then
				self:SetP1(tr.HitPos+tr.HitNormal*20)
			else
				self:SetP2(tr.HitPos+tr.HitNormal*20)
			end

			self.point_selected= !self.point_selected
		end

		self.next_reload=CurTime()+1
	end
end

local mat = Material("models/wireframe")

function SWEP:VoxlDraw()
	
	local min = self:GetP1()
	local max = self:GetP2()
	
	OrderVectors(min,max)

	render.SetMaterial(mat)

	render.DrawBox(min,Angle(0,0,0),Vector(),max-min)
end