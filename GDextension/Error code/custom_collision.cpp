#include "gdexample.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void CustomCollision::_bind_methods() {
    ClassDB::bind_method(D_METHOD("_ready"), &CustomCollision::_ready);
    ClassDB::bind_method(D_METHOD("_process", "delta"), &CustomCollision::_process);
}

CustomCollision::CustomCollision() {
    temspeed1 = Vector2(100, 0); // 初始化速度
    temspeed2 = Vector2(-100, 0); // 初始化速度
}

CustomCollision::~CustomCollision() { }

void CustomCollision::_ready() {
    body_a = Object::cast_to<RigidBody2D>(get_node(NodePath("circle1")));
    body_b = Object::cast_to<RigidBody2D>(get_node(NodePath("circle2")));

    if (body_a != nullptr) {
        body_a->set_linear_velocity(temspeed1);
    }
    if (body_b != nullptr) {
        body_b->set_linear_velocity(temspeed2);
    }
}

void CustomCollision::_process(double delta) {
    if (body_a == nullptr || body_b == nullptr) {
        return; // 如果节点没有正确获取，直接返回
    }

    Vector2 position_a = body_a->get_position();
    Vector2 position_b = body_b->get_position();

    float distance = position_a.distance_to(position_b);
    if (distance <= collision_distance) {
        body_a->set_linear_velocity(-temspeed1);
        body_b->set_linear_velocity(-temspeed2);
    }
}


