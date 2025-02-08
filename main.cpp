#include "raylib.h"
#include <iostream>
#include <ranges>
#include <vector>

int main() {
  // Initialization
  const int screenWidth = 800;
  const int screenHeight = 450;

  InitWindow(screenWidth, screenHeight, "Raylib - Basic Window Example");

  SetTargetFPS(60); // Set the game to run at 60 frames per second

  // Main game loop
  while (!WindowShouldClose()) { // Detect window close button or ESC key
    // Start drawing
    BeginDrawing();

    ClearBackground(RAYWHITE); // Clear the screen with a white background

    DrawText("Hello, Raylib!", 190, 200, 20, LIGHTGRAY); // Display text

    EndDrawing();
  }

  // De-initialization
  CloseWindow(); // Close window and unload resources

  return 0;
}
