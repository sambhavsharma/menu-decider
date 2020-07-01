require 'net/smtp'

def get_days(num)
	return 86400 * num;
end

days = ["Mon","Tue","Wed","Thu","Friday","Sat","Sun"];
dishes = {
	"Karhi": "healthy",
	"chole chawal": "healthy",
	"dosa": "healthy",
	"chilli potatoes": "unhealthy",
	"toor daal": "healthy",
	"gobhi parantha": "healthy",
	"gobhi sabji": "healthy",
	"masoor daal": "healthy",
	"mix veg": "healthy",
	"capsicum": "healthy",
	"khichdi": "healthy",
	"baigan bharta": "healthy",
	"matar pulao": "healthy",
	"uttapam": "halthy",
	"poha": "healthy",
	"jave": "healthy",
	"upma": "halthy",
	"cheela": "halthy",
	"noodles": "unhealthy",
	"burger": "unhealthy",
	"chole bhature": "unhealthy",
	"eggs": "healthy",
	"tortilla/sandwich": "unhealthy",
	"fried rice": "unhealthy",
	"puff toast": "unhealthy"
};

unhealthy_count = 4;
all_dishes = dishes.keys;
num_dishes = all_dishes.count;

meals = ['lunch','dinner'];

next_monday = Time.new + get_days((7 - Time.new.wday) + 1);

menu = {};

unhealthy_dishes = dishes.keys.map { |dish| dish if dishes[dish] == 'unhealthy' }.compact;


for day in days
	
	menu[day] = {};
	
	for meal in meals

		dish_index = rand(num_dishes);
		dish = all_dishes[dish_index]
		menu[day][meal] = dish;

		all_dishes.delete_at(dish_index);
		num_dishes -= 1;
		unhealthy_count -= 1 if dishes[dish] == 'unhealthy';

		((all_dishes -= unhealthy_dishes) && (num_dishes = all_dishes.count)) if unhealthy_count == 0;
	end
end


File.open('this_weeks_menu.txt', 'w') { |file| 

	message = "\nMenu for the Week: " + next_monday.strftime("%Y-%m-%d") + " - " + (next_monday + get_days(7)).strftime("%Y-%m-%d");

	puts message;
	file.write(message); 

	for day in days 

		message = "\n" + day + " => \n";
		puts message;
		file.write(message); 
		
		todays_menu = menu[day];
		for meal in meals

			message = meal + ": " + todays_menu[meal].to_s + "\n";
			puts message;
			file.write(message);
		end
	end
}

