// Position = Where the rocket is currently
// Speed (velocity) = distance/time
// Acceleration = Speed/time
// Force = direction of acceleration
// PVector = coordinates pair from 0,0 (top right corner)

Rocket serenity;
final int LIFETIME = 100;

void setup() {
	size(1200, 1200);
	serenity = new Rocket(new PVector(200, 400));
}

void draw() {
	background(42, 160, 255);
	serenity.run();
	serenity.display();
}

// void keyPressed() {
// 	if (keyCode == RIGHT) {
// 		serenity.applyForce(new PVector(5,0));
// 	}
// 	if (keyCode == LEFT) {
// 		serenity.applyForce(new PVector(-5,0));
// 	}
// 	if (keyCode == UP) {
// 		serenity.applyForce(new PVector(0,-5));
// 	}
// 	if (keyCode == DOWN) {
// 		serenity.applyForce(new PVector(0,5));
// 	}
// }