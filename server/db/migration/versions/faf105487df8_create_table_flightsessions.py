"""create table flightsessions

Revision ID: faf105487df8
Revises: 469c3e97a602
Create Date: 2024-09-03 22:44:28.201434

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic.
revision: str = 'faf105487df8'
down_revision: Union[str, None] = '469c3e97a602'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        'flightsessions',
        sa.Column('id', sa.Integer, primary_key=True, autoincrement=True),
        sa.Column('pilotid', sa.String, sa.ForeignKey('pilots.id'), nullable=False),
        sa.Column('terminalid', sa.String, nullable=False),
        sa.Column('start', sa.DateTime, nullable=False),
        sa.Column('end', sa.DateTime, nullable=True),
        sa.Column('takeoffcount', sa.Integer, nullable=True),
        sa.Column('maxAltitude', sa.Integer, nullable=True),
        sa.Column('airspaceObserver', sa.Boolean, nullable=True),
        sa.Column('comment', sa.String, nullable=True),
    )


def downgrade() -> None:
    op.drop_table('flightsessions')
