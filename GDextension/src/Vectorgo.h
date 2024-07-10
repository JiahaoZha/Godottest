#ifndef VECTORGO_H
#define VECTORGO_H

#include <godot_cpp/classes/Node3d.hpp>

namespace godot {

	class Vectorgo : public Node3D {
		GDCLASS(Vectorgo, Node3D)

	private:
		double time_passed;

	protected:
		static void _bind_methods();

	public:
		Vectorgo();
		~Vectorgo();

		void _process(double delta) override;
	};

}

#endif