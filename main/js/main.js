//custom function
var dataset_tranfer = function(input_data, duration, color, opacity){	
	for (i=0; i<input_data.length; i++){
		input_data[i].push(duration);
		input_data[i].push(color);
		input_data[i].push(opacity);
	}
	return(input_data);
}

// load data
d3.json('data/result.json', function(data){
	var square = 40,
		width = data['grid_dimension'][1] * square,
		height = data['grid_dimension'][0] * square,
		barWidth = square,
		barHeight = square,
		barOffset = 0;

		wall = data['wall'];
		steps = data['steps'];
		exit_path = data['exit_path'];
		entrance = [data['entrance']];
		exit = [data['exit']];

		dataset_tranfer(exit,40,'blue',1);
		dataset_tranfer(entrance,40,'green',1);
		dataset_tranfer(wall,40,'#C61C6F',1);
		dataset_tranfer(steps,100,'black',0.4);
		dataset_tranfer(exit_path,100,'blue',0.4);		
		dataset = (((wall.concat(entrance)).concat(exit)).concat(steps)).concat(exit_path);
	// create the svg
	var svg = d3.select('#chart').append('svg')	
			.attr('width', width)
			.attr('height', height)
			.style('background','#C9D7D6')
			.selectAll('wall').data(dataset)
			.enter().append('rect')
			.style('fill', function(d){
				return d[3];
			})
			.style('opacity',function(d){
				return d[4];
			})
			.attr('width',0)
			.attr('x', 0)
			.attr('height',0)				
			.attr('y', 0);

	svg.transition()
			.attr('width',barWidth)
			.attr('x', function(d){
				return d[1] * (barWidth + barOffset);
			})
			.attr('height',barHeight)				
			.attr('y', function(d){
				return d[0] * (barWidth + barOffset);
			})
			.duration(function(d,i){
				return 200;
			})
			.delay(function(d,i){
				return d[2]*i;
			});
			;
});
