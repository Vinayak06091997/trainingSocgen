import { useEffect, useState } from 'react';

const API_BASE = import.meta.env.VITE_API_BASE || 'http://localhost:8081';

function App() {
  const [users, setUsers] = useState([]);
  const [name, setName] = useState('');
  const [status, setStatus] = useState('');

  useEffect(() => {
    fetch(`${API_BASE}/api/users`)
      .then((res) => res.json())
      .then(setUsers)
      .catch(() => setStatus('Unable to reach backend'));
  }, []);

  const addUser = async (event) => {
    event.preventDefault();
    if (!name.trim()) return;

    const response = await fetch(`${API_BASE}/api/users`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name: name.trim() }),
    });

    if (response.ok) {
      setName('');
      setStatus('User added successfully');
      const updated = await response.json();
      setUsers((prev) => [...prev, updated]);
    } else {
      const error = await response.json();
      setStatus(error.error || 'Failed to add user');
    }
  };

  return (
    <div className="app-container">
      <header>
        <h1>React + Java + SQL Sample App</h1>
        <p>Frontend connects to backend, backend stores users in PostgreSQL.</p>
      </header>

      <section className="card">
        <h2>Users</h2>
        <ul>
          {users.length === 0 ? <li>No users yet</li> : users.map((user) => <li key={user.id}>{user.name}</li>)}
        </ul>
      </section>

      <section className="card">
        <h2>Add a new user</h2>
        <form onSubmit={addUser}>
          <input
            value={name}
            onChange={(e) => setName(e.target.value)}
            placeholder="Enter a name"
          />
          <button type="submit">Add user</button>
        </form>
        {status && <p className="status">{status}</p>}
      </section>
    </div>
  );
}

export default App;
