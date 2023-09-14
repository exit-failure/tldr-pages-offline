#include "pack_pages.h"

void get_pages(string dir) {
	for (const auto & entry : fs::directory_iterator(dir)){
		if(is_regular_file(entry)){
			add_page(entry);
		}
        else if(fs::is_directory(entry)){
			cout << fg::red << "Warning, subdirectory \'" << entry.path().relative_path() << "\' in path \'" << dir << "\' found. There should be no directories here." << endl;
		}
		else {
			cout << fg::red << "Warning, object \'" << entry.path().relative_path() << "\' found in \'" << dir << "\' is not a regular file." << endl;
		}
	}
}

void add_page(fs::directory_entry file) {
	//IMPL
}

void write_header() {
	//IMPL
}

int main() {
	//IMPL
	exit(EXIT_FAILURE);
}
