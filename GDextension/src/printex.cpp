#include "printex.h"
#include <string>
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/variant/utility_functions.hpp>
#include "Hello_world.h"
using namespace godot;

void printex::_bind_methods() {
	ClassDB::bind_method(D_METHOD("theword"), &printex::theword);
	
}

printex::printex() {
	// Initialize any variables here.
}

printex::~printex() {
	// Add your cleanup here.
}

void printex::theword() {
	std::string std_words = hello_world();
	String words = String(std_words.c_str());
	UtilityFunctions::print(words);
}