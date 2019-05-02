// Position = Where the rocket is currently
// Speed (velocity) = distance/time
// Acceleration = Speed/time
// Force = direction of acceleration
// PVector = coordinates pair from 0,0 (top right corner)

Rocket serenity;

void setup() {
	size(1200, 1200);
	serenity = new Rocket(new PVector(200, 400));
}

void draw() {
	background(42, 160, 255);
	serenity.update();
	serenity.display();
}

void keyPressed() {
	serenity.applyForce(new PVector(5, 0));
}