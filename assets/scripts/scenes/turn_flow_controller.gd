class_name TurnFlowController

var _turn_queue: Queue
var _min_turn_count: int = 10

var _verbose: bool = true


func _init(playerIds: Array[int], enemyIds: Array[int]) -> void:
	if (_verbose):
		print("[TURN QUEUE] Initializing queue")

	_turn_queue = Queue.new()
	_fill_turn_queue(playerIds, enemyIds)

	return


func get_next_turn(remainingPlayerIds: Array[int], remainingEnemyIds: Array[int]) -> int:
	var nextToPlayIsValid: bool = false
	var nextToPlay: int

	while (!nextToPlayIsValid):
		if (_turn_queue.size() <= 0):
			push_error("Unable to find valid next turn actor on turn flow queue")

		nextToPlay = _turn_queue.dequeue()
		if (remainingPlayerIds.find(nextToPlay) || remainingEnemyIds.find(nextToPlay)):
			nextToPlayIsValid = true
		else:
			_turn_queue.force_remove_aparitions(nextToPlay)

	_fill_turn_queue(remainingPlayerIds, remainingEnemyIds)

	return nextToPlay


func _fill_turn_queue(remainingPlayerIds: Array[int], remainingEnemyIds: Array[int]) -> void:
	print("[TURN QUEUE] Fill turn queue. Rem players: " + str(remainingEnemyIds.size()) + "; Rem enemies: " + str(remainingEnemyIds.size()))

	var fullIdList: Array[int] = remainingPlayerIds.duplicate(true)
	fullIdList.append_array(remainingEnemyIds.duplicate(true))

	var lastOnQueue: int = _turn_queue.peek_queue_end()
	var startingIndex: int
	if (remainingPlayerIds.has(lastOnQueue)):
		startingIndex = remainingPlayerIds.size()
	elif (remainingEnemyIds.has(lastOnQueue)):
		startingIndex = remainingPlayerIds.size() + remainingEnemyIds.find(lastOnQueue)
	else:
		push_error("can't find last actor from turn queue, make sure the list is updated before calling this func")

	_enqueue_turns_until_full(fullIdList, startingIndex)

	return


func _enqueue_turns_until_full(fullIdList: Array[int], startingIndex: int = -1) -> void:
	print("[TURN QUEUE] Enqueuing until full. Current count: " + str(_turn_queue.size()) + "; FullIdList count: " + str(fullIdList.size()) + "; Starting index: " + str(startingIndex))

	var index: int = startingIndex if startingIndex > 0 else 0

	while (_turn_queue.size() < _min_turn_count):
		print("[TURN QUEUE] Current count: " + str(_turn_queue.size()) + "Next id to enqueue: " + str(fullIdList[index % fullIdList.size()]))
		_turn_queue.enqueue(fullIdList[index % fullIdList.size()])
		index += 1

	return