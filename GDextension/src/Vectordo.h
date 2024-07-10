#ifndef VECTORDO_H
#define VECTORDO_H

#include <godot_cpp/classes/Node3d.hpp>
#include <string>
#include <thread>

namespace godot {

class Vectordo : public Node3D {
	GDCLASS(Vectordo, Node3D)

private:
	String Wordout;
	double time_passed;
	bool process_running;
	std::thread exe_thread;
	std::string exec(const char* cmd);

protected:
	static void _bind_methods();

public:
	Vectordo();
	~Vectordo();

	void _ready();
	void _process(double delta) override;

	void open_exe();
	void close_exe();

};

}

#endif