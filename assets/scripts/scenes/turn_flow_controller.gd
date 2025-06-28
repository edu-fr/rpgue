class_name TurnFlowController

var _turn_queue: Queue
var _min_turn_count: int = 10


func _init(playerIds: Array[int], enemyIds: Array[int]) -> void:
	if (GM.verbose):
		print("[TURN QUEUE] Initializing queue")

	_turn_queue = Queue.new()
	_fill_turn_queue(playerIds, enemyIds)

	return


func get_next_turn(remainingPlayerIds: Array[int], remainingEnemyIds: Array[int]) -> int:
	var nextToPlayIsValid: bool = false
	var nextToPlay: int
	print("\n[TURN QUEUE] Getting next turn")

	while (!nextToPlayIsValid):
		if (_turn_queue.size() <= 0):
			push_error("Unable to find valid next turn actor on turn flow queue")

		nextToPlay = _turn_queue.dequeue()
		if (remainingPlayerIds.has(nextToPlay) || remainingEnemyIds.has(nextToPlay)):
			nextToPlayIsValid = true
		else:
			print("[TURN QUEUE] Removing actor " + str(nextToPlay) + " from queue because it's not in battle anymore")
			_turn_queue.force_remove_aparitions(nextToPlay)

	_fill_turn_queue(remainingPlayerIds, remainingEnemyIds)

	print("[TURN QUEUE] Next actor to play: " + str(nextToPlay))

	return nextToPlay


func _fill_turn_queue(remainingPlayerIds: Array[int], remainingEnemyIds: Array[int]) -> void:
	print("[TURN QUEUE] Remaining players: " + str(remainingPlayerIds.size()) + ". And enemies: " + str(remainingEnemyIds.size()))
	var fullIdList: Array[int] = []

	for _id: int in remainingPlayerIds:
		fullIdList.append(_id)

	for _id: int in remainingEnemyIds:
		fullIdList.append(_id)

	var _startingIndex: int

	if (_turn_queue.peek_queue_end() == null):
		_startingIndex = 0
	else:
		var _last_of_the_queue: int = _turn_queue.peek_queue_end()

		var _is_last_enemy: bool = not remainingEnemyIds.is_empty() and remainingEnemyIds.back() == _last_of_the_queue
		if (_is_last_enemy):
			_startingIndex = 0
		else:
			var last_actor_index: int = fullIdList.find(_last_of_the_queue)
			if (last_actor_index != -1):
				_startingIndex = (last_actor_index + 1) % fullIdList.size()
			else:
				push_error("[TURN QUEUE] Can't find last actor from turn queue, make sure the list is updated before calling this func")
				_startingIndex = 0 # Fallback para um índice seguro

	_enqueue_turns_until_full(fullIdList, _startingIndex)

	return



func _enqueue_turns_until_full(fullIdList: Array[int], startingIndex: int = -1) -> void:
	print("[TURN QUEUE] Enqueuing until full. (" + str(_turn_queue.size()) + "/" + str(_min_turn_count) + ")")

	var index: int = startingIndex if startingIndex > 0 else 0

	while (_turn_queue.size() < _min_turn_count):
		_turn_queue.enqueue(fullIdList[index % fullIdList.size()])
		index += 1

	print("[TURN QUEUE] Enqueued! (" + str(_turn_queue.size()) + "/" + str(_min_turn_count) + ")")

	print(_turn_queue)

	return