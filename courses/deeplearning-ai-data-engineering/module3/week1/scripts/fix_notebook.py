import json

# Read the notebook
with open('C3_W1_Assignment.ipynb', 'r') as f:
    notebook = json.load(f)

# Exercise cells that need print(records) added
exercises_needing_print = [
    'ex05', 'ex06', 'ex07', 'ex08', 'ex09', 'ex10', 
    'ex11', 'ex12', 'ex13', 'ex14', 'ex15', 'ex16'
]

# Iterate through cells
for cell in notebook['cells']:
    if cell['cell_type'] == 'code':
        # Check if this is an exercise cell
        metadata = cell.get('metadata', {})
        exercise = metadata.get('exercise', [])
        
        if exercise and exercise[0] in exercises_needing_print:
            # Check if the cell ends with records = execute_query(query) without print
            source = cell['source']
            if source:
                last_line = source[-1].strip() if isinstance(source[-1], str) else ''
                
                # If last line is records = execute_query(query) without print after
                if 'records = execute_query(query)' in last_line and 'print(records)' not in ''.join(source):
                    print(f"Adding print(records) to {exercise[0]}")
                    # Add print(records) as a new line
                    if source[-1].endswith('\n'):
                        source.append('print(records)')
                    else:
                        source[-1] = source[-1] + '\n'
                        source.append('print(records)')

# Write the fixed notebook
with open('C3_W1_Assignment.ipynb', 'w') as f:
    json.dump(notebook, f, indent=1)

print("\nNotebook fixed!")
