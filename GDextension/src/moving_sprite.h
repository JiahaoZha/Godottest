#ifndef MOVING_SPRITE_H
#define MOVING_SPRITE_H

#include <godot_cpp/classes/collision_shape2d.hpp>
#include <godot_cpp/classes/circle_shape2d.hpp>
#include <godot_cpp/classes/rigid_body2d.hpp>
#include <godot_cpp/classes/Physics_Direct_Body_State2D.hpp>
#include <godot_cpp/classes/physics_material.hpp>
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/variant/vector2.hpp>

namespace godot {

    class MovingSprite : public RigidBody2D {
        GDCLASS(MovingSprite, RigidBody2D)

    private:
        float speed;
        bool moving;
        double time_passed;
        bool has_collided;
        Ref<CircleShape2D> circle_shape;
        CollisionShape2D* collision_shape;
        Ref<PhysicsMaterial> material;

    protected:
        Vector2 velocity;
        static void _bind_methods();

    public:
        MovingSprite();
        ~MovingSprite();

        virtual void _ready() override;
        virtual void _process(double delta) override;
        void _integrate_forces(PhysicsDirectBodyState2D* state) override;
        void set_speed(float p_speed);
        float get_speed() const;
        void stop();
        void start();
        void handle_collision(MovingSprite* other);
        void set_physics_properties();
    };

} // namespace godot

#endif // MOVING_SPRITE_H

