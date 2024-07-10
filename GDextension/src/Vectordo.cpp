#include "Vectordo.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>
#include <godot_cpp/variant/string.hpp>

#include <windows.h>
#include <iostream>
#include <cstdio>
#include <memory>
#include <stdexcept>
#include <string>
#include <array>
#include <thread>
#include <chrono>

#ifdef _WIN32
#define popen _popen
#define pclose _pclose
#endif

using namespace godot;

void Vectordo::_bind_methods() {

	ClassDB::bind_method(D_METHOD("open_exe"), &Vectordo::open_exe);
	ClassDB::bind_method(D_METHOD("close_exe"), &Vectordo::close_exe);
}

Vectordo::Vectordo() {

	time_passed = 0.0;

}

Vectordo::~Vectordo() {
	//cleanup

}
void Vectordo::_ready() {
	// Initialization

	UtilityFunctions::print("Vectordo is ready.");
	open_exe();
	
}



void Vectordo::open_exe() {
	const char* command = "Vector_sender.exe";
	process_running = true;
	exe_thread = std::thread([this, command]() {
		try {
			while (process_running) {
				UtilityFunctions::print("try print");
				std::string output = exec(command);
				if (output.empty()) {
					UtilityFunctions::print("exec returned an empty string.");
				}
				Wordout = String(String(output.c_str()));
				UtilityFunctions::print("output is", Wordout);

				
			}
		}
		catch (const std::exception& e) {
			UtilityFunctions::print("error");
		}
		});
	UtilityFunctions::print("Executable started.");
}

void Vectordo::close_exe() {
	process_running = false;
	if (exe_thread.joinable()) {
		exe_thread.join();
	}
	UtilityFunctions::print("Executable closed successfully.");
}

std::string Vectordo::exec(const char* cmd) {
	std::array<char, 128> buffer;
	std::string result;
	std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd, "r"), pclose);
	if (!pipe) {
		UtilityFunctions::print("Failed to open pipe!");
	}
	while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
		result += buffer.data();
	}
	return result;
}






void Vectordo::_process(double delta) {

	if (time_passed > 5.0) {
		close_exe();
	}




	time_passed += delta;

	Vector3 new_position = Vector3(1.0+ time_passed, 0.0, 0.0);

	set_position(new_position);
}
