#include "moving_sprite.h"
#include <godot_cpp/variant/utility_functions.hpp>

using namespace godot;

void MovingSprite::_bind_methods() {
    ClassDB::bind_method(D_METHOD("set_speed", "speed"), &MovingSprite::set_speed);
    ClassDB::bind_method(D_METHOD("get_speed"), &MovingSprite::get_speed);
    ClassDB::bind_method(D_METHOD("stop"), &MovingSprite::stop);
    ClassDB::bind_method(D_METHOD("start"), &MovingSprite::start);

    ADD_PROPERTY(PropertyInfo(Variant::FLOAT, "speed"), "set_speed", "get_speed");
}

MovingSprite::MovingSprite() {
    speed = 200;
    moving = true;
    has_collided = false;
    time_passed = 0.0;
    velocity = Vector2(speed, 0);

    // 初始化碰撞形状
    circle_shape.instantiate();
    circle_shape->set_radius(16);

    collision_shape = memnew(CollisionShape2D);
    collision_shape->set_shape(circle_shape);
    add_child(collision_shape);
}

MovingSprite::~MovingSprite() {
}

void MovingSprite::_ready() {
    material.instantiate();
    material->set_bounce(1.0);  // 弹性
    set_physics_material_override(material);

    // 设物理属性
    set_physics_properties();
}

void MovingSprite::set_physics_properties() {
    // 设置最大接触报告数量和接触监视器
    set_max_contacts_reported(1);
    set_contact_monitor(true);
}

void MovingSprite::_process(double delta) {
    if (moving) {
        set_position(get_position() + velocity * delta);
        time_passed += delta;

        if (time_passed >= 10.0) {
            moving = false;
        }
    }
}

void MovingSprite::set_speed(float p_speed) {
    speed = p_speed;
    velocity = Vector2(speed, 0);
}

float MovingSprite::get_speed() const {
    return speed;
}

void MovingSprite::stop() {
    moving = false;
}

void MovingSprite::start() {
    moving = true;
    has_collided = false;
    time_passed = 0.0; // 重置
}

void MovingSprite::handle_collision(MovingSprite* other) {
    if (!has_collided && !other->has_collided) {
        Vector2 temp = velocity;
        velocity = other->velocity;
        other->velocity = temp;
        has_collided = true;
        other->has_collided = true;

        // 强制更新位置以避免重叠
        set_position(get_position() + velocity * 0.01);
        other->set_position(other->get_position() + other->velocity * 0.01);
    }
}

void MovingSprite::_integrate_forces(PhysicsDirectBodyState2D* state) {
    if (!moving) {
        return;
    }

    // 获取所有碰撞的形状
    for (int i = 0; i < state->get_contact_count(); i++) {
        RigidBody2D* collider = Object::cast_to<RigidBody2D>(state->get_contact_collider_object(i));
        if (collider) {
            MovingSprite* other = Object::cast_to<MovingSprite>(collider);
            if (other) {
                handle_collision(other);
            }
        }
    }

    // 更新物体位置
    state->set_linear_velocity(velocity);
}

