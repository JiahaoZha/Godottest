#include "Vectorgo.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void Vectorgo::_bind_methods() {
}

Vectorgo::Vectorgo() {
	// Initialize any variables here.
	time_passed = 0.0;
}

Vectorgo::~Vectorgo() {
	// Add your cleanup here.
}

void Vectorgo::_process(double delta) {
	time_passed += delta;

	Vector3 new_position = Vector3(1 + time_passed, 1, 1);

	set_position(new_position);
}