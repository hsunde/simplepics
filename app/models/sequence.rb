module Sequence
    def self.update_order(files, sequence)
		files.each_with_index do |file, i| # get order from GUI
			DB[:sequences].where(sequence: sequence, file: file.to_i).update(order: i + 1)
		end        
    end

    def self.get_sequence(target)
        return DB[:sequences].where(file: target.to_i).first[:sequence]
    end

    def self.new_sequence(object, target)
        max_sequence = DB[:sequences].max(:sequence).to_i
		DB[:sequences].insert(file: object, sequence: max_sequence + 1, order: 1)
		DB[:sequences].insert(file: target, sequence: max_sequence + 1, order: 2)

        return (max_sequence + 1).to_s
    end

    def self.add(object, target, files) # to existing sequence
        sequence = get_sequence(target)
        DB[:sequences].insert(file: object, sequence: sequence, order: 0)
        update_order(files, sequence)
    end

    def self.move(object, target, files) # from one sequence to another
        sequence = get_sequence(target)
        DB[:sequences].where(file: object).update(sequence: sequence)
        update_order(files, sequence)
    end

    def self.remove(object)
        sequence = get_sequence(object)
        DB[:sequences].where(file: object).delete

        in_sequence = DB[:sequences].where(sequence: sequence)
        if in_sequence.count == 1
            in_sequence.delete
        end
    end
end

