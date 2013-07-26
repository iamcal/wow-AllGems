AllGems = {};

-- ############################# Slash Commands #############################

SLASH_AllGems1 = '/ag';
SLASH_AllGems2 = '/allgems';

function SlashCmdList.AllGems(msg, editBox)

	local map = {
		{ color = "Blue",	id = 76636 }, -- Rigid
		{ color = "Blue",	id = 76637 }, -- Stormy
		{ color = "Blue",	id = 76638 }, -- Sparkling
		{ color = "Blue",	id = 76639 }, -- Solid

		{ color = "Red",	id = 76692 }, -- Delicate
		{ color = "Red",	id = 76693 }, -- Precise
		{ color = "Red",	id = 76694 }, -- Brilliant
		{ color = "Red",	id = 76695 }, -- Flashing
		{ color = "Red",	id = 76696 }, -- Bold

		{ color = "Yellow",	id = 76697 }, -- Smooth
		{ color = "Yellow",	id = 76698 }, -- Subtle
		{ color = "Yellow",	id = 76699 }, -- Quick
		{ color = "Yellow",	id = 76700 }, -- Fractured
		{ color = "Yellow",	id = 76701 }, -- Mystic

		{ color = "Orange",	id = 76670 }, -- Adept
		{ color = "Orange",	id = 76658 }, -- Deadly
		{ color = "Orange",	id = 76660 }, -- Potent
		{ color = "Orange",	id = 76661 }, -- Inscribed
		{ color = "Orange",	id = 76662 }, -- Polished
		{ color = "Orange",	id = 76663 }, -- Resolute
		{ color = "Orange",	id = 76664 }, -- Stalwart
		{ color = "Orange",	id = 76665 }, -- Champion's
		{ color = "Orange",	id = 76666 }, -- Deft
		{ color = "Orange",	id = 76667 }, -- Wicked
		{ color = "Orange",	id = 76668 }, -- Reckless
		{ color = "Orange",	id = 76669 }, -- Fierce
		{ color = "Orange",	id = 76659 }, -- Crafty
		{ color = "Orange",	id = 76671 }, -- Keen
		{ color = "Orange",	id = 76672 }, -- Artful
		{ color = "Orange",	id = 76673 }, -- Fine
		{ color = "Orange",	id = 76674 }, -- Skillful
		{ color = "Orange",	id = 76675 }, -- Lucent
		{ color = "Orange",	id = 76676 }, -- Tenuous
		{ color = "Orange",	id = 76677 }, -- Willful
		{ color = "Orange",	id = 76678 }, -- Splendid
		{ color = "Orange",	id = 76679 }, -- Respledent

		{ color = "Purple",	id = 76687 }, -- Shifting
		{ color = "Purple",	id = 76680 }, -- Glinting
		{ color = "Purple",	id = 76682 }, -- Veiled
		{ color = "Purple",	id = 76683 }, -- Retaliating
		{ color = "Purple",	id = 76684 }, -- Etched
		{ color = "Purple",	id = 76685 }, -- Mysterious
		{ color = "Purple",	id = 76686 }, -- Purified
		{ color = "Purple",	id = 76681 }, -- Accurate
		{ color = "Purple",	id = 76688 }, -- Guardian's
		{ color = "Purple",	id = 76689 }, -- Timeless
		{ color = "Purple",	id = 76690 }, -- Defender's
		{ color = "Purple",	id = 76691 }, -- Sovereign
		{ color = "Purple",	id = 89674 }, -- Tense
		{ color = "Purple",	id = 89680 }, -- Assassin's

		{ color = "Green",	id = 76650 }, -- Shattered
		{ color = "Green",	id = 76640 }, -- Misty
		{ color = "Green",	id = 76642 }, -- Lightning
		{ color = "Green",	id = 76643 }, -- Sensei's
		{ color = "Green",	id = 76644 }, -- Effulgent
		{ color = "Green",	id = 76645 }, -- Zen
		{ color = "Green",	id = 76646 }, -- Balanced
		{ color = "Green",	id = 76647 }, -- Vivid
		{ color = "Green",	id = 76648 }, -- Turbid
		{ color = "Green",	id = 76649 }, -- Radiant
		{ color = "Green",	id = 76641 }, -- Piercing
		{ color = "Green",	id = 76651 }, -- Energized
		{ color = "Green",	id = 76652 }, -- Jagged
		{ color = "Green",	id = 76653 }, -- Regal
		{ color = "Green",	id = 76654 }, -- Forceful
		{ color = "Green",	id = 76655 }, -- Confounded ??
		{ color = "Green",	id = 93705 }, -- Nimble ??
		{ color = "Green",	id = 76656 }, -- Pussant
		{ color = "Green",	id = 76657 }, -- Steady
	};

	local colors = {"Blue", "Red", "Yellow", "Orange", "Purple", "Green"};


	-- get list of recipes

	local i,v;
	local j,w;
	local state = {};

	for i=1,GetNumTradeSkills() do
		local name = GetTradeSkillInfo(i);
		if (name) then
			state[name] = true;
		end
	end


	-- update state into map, build total counts

	local total = 0;
	local totals = {};
	local counts = {};

	for i,v in ipairs(map) do

		map[i].name = GetItemInfo(map[i].id);
		map[i].got = state[map[i].name];

		if (map[i].got) then
			counts[map[i].color] = (counts[map[i].color] or 0) + 1;
			total = total + 1;
		end

		totals[map[i].color] = (totals[map[i].color] or 0) + 1;
	end


	-- nothing found?

	if (total == 0) then
		print("No gems found - open your JC window!");
		return;
	end


	-- asked for a color?

	if (string.len(msg) > 0) then
		color = string.upper(string.sub(msg, 1, 1)) .. string.lower(string.sub(msg, 2));
		if (totals[color])then

			local num = counts[color]
			local tot = totals[color];

			local col = 'FF0000';
			if (num == tot) then
				col = '00FF00';
			end

			print(string.format("%s Gems (|cFF%s%d/%d|r)", color, col, num, tot));

			for i,v in ipairs(map) do

				if (v.color == color) then

					local col = 'FF0000';
					if (v.got) then
						col = '00FF00';
					end

					print(string.format(" - |cFF%s%s|r", col, v.name));
				end
			end

			return;
		end
	end


	-- general summary

	for i,v in ipairs(colors) do

		local num = counts[v] or 0;
		local tot = totals[v] or 1;

		local color = 'FF0000';
		if (num == tot) then
			color = '00FF00';
		end

		print(string.format("%s : |cFF%s%d/%d|r", v, color, num, tot));
	end
end
