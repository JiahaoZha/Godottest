#ifndef PRINTEX_H
#define PRINTEX_H

#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/variant/string.hpp>
namespace godot {

	class printex : public Node {
		GDCLASS(printex, Node)

	private:
		String words;

	protected:
		static void _bind_methods();

	public:
		printex();
		~printex();
		void theword();
	
	};

}
#endif