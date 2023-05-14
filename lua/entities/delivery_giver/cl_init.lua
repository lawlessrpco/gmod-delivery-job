include("shared.lua")

surface.CreateFont("Delivery:GiverTitle", {
    font = "Arial",
    size = 60,
    weight = 500,
})

function ENT:DrawTranslucent()
    self:DrawModel() -- draw the base model

    cam.Start3D2D(self:GetPos() + self:GetUp() * 75 + (self:GetUp() * math.sin(CurTime() * 3.5)), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.1)
        draw.SimpleText(self.Title, "Delivery:GiverTitle", 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
    cam.End3D2D()
end
