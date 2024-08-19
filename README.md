# Scope Sway

This is a [Godot 4.3](https://godotengine.org/) project demonstrating how you can use [Lissajous curves](https://en.wikipedia.org/wiki/Lissajous_curve) for scope/weapon sway.

Summary video on YouTube: [Gamedev Tip: Scope Sway in Godot 4.3](https://www.youtube.com/watch?v=Zaq4I10QILE)

The `ScopeSway2D` node in `scope_demo_2d.tscn` orbits around its parent in 2D. It could, for example, be be the child of a node that follows the cursor, in which case the player would need to offset their input.

In `scope_demo_3d.tscn` the `ScopeSway3D` node rotates itself relative to the camera. The idea being that its forward vector represents the final aiming direction. Alternatively, it could be the parent of the camera. (This is essentially how it works in Unturned 3.)

I should clarify that I'm certainly no mathematician! I believe I first read about this approach in a forum or blog post, but it didn't occur to me to save the link in a code comment back then, unfortunately.
