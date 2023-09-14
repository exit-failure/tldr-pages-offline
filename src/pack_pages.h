#ifndef _pack_pages_h_
#define _pack_pages_h_

#include <iostream>
#include <string>
#include <stdlib.h>
#include <filesystem>
#include "lib/rang.hpp"

using namespace std;
using namespace rang;
namespace fs = std::filesystem;

void get_pages(string dir);
void add_page(fs::directory_entry file);
void write_header();

#endif //#ifndef _pack_pages.h_
