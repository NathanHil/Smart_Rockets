// Yong's Rocket class from
//https://gist.github.com/ybakos/f8a88da3cf382ba707c20277aa38ef71

class Rocket {

	// Position = Where the rocket is currently
	// Speed (velocity) = distance/time
	// Acceleration = Speed/time
	// Force = direction of acceleration

	PVector position;
	PVector velocity;
	PVector acceleration;

	float size;

	Rocket(PVector location) {
		acceleration = new PVector();
		velocity = new PVector();
		position = location.get();
		size = 4;
	}

	// Tell rocket what force to apply every frame
	void applyForce(PVector f) {
		acceleration.add(f);
	}

	// Always telling every single rocket to update position based on velocity every single frame
	void update() {
		velocity.add(acceleration);
		position.add(velocity);
		acceleration.mult(0); // Reset to 0 so doesn't accelerate forever
	}

	void display() {
		float theta = velocity.heading2D() + PI/2;
		fill(200, 100);
		stroke(255); // Color of rocket
		pushMatrix(); // Keep track of state to pop later
		translate(position.x, position.y); // Move to rocket's position
		rotate(theta); // Rotate canvas to draw

		// Thrusters
		rectMode(CENTER);
		fill(0);
		rect(-size/2, size*2, size/2, size);
		rect(size/2, size*2, size/2, size);

		// Fuselage
		fill(120);
		beginShape(TRIANGLES);
		vertex(0, -size*2);
		vertex(-size, size*2);
		vertex(size, size*2);
		endShape();

		popMatrix();
	}

}